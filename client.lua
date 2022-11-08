local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    DebugPrint("Spawning PED")
    SpawnPed()
    DebugPrint("Spawned PED")
    DebugPrint("Creating Blip")
    CreateBlips()
    DebugPrint("Created Blip")
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    DebugPrint("Spawning PED")
    SpawnPed()
    DebugPrint("Spawned PED")
    DebugPrint("Creating Blip")
    CreateBlips()
    DebugPrint("Created Blip")
end)

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then
      -- Remove all peds and blips
        for k, v in pairs(Config.PedLocations) do
             if DoesEntityExist(v.Ped) then
                DeletePed(v.Ped)
             end
        end
        for k, v in pairs(Config.Blips) do
            if DoesBlipExist(v.Blip) then
                RemoveBlip(v.Blip)
            end
        end
   end
end)


function SpawnPed()
    CreateThread(function()
        RequestModel(Config.PedModel)
        while not HasModelLoaded(Config.PedModel) do Wait(1) end
        ped = CreatePed(2, Config.PedModel, Config.PedLocation, true, false)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedDiesWhenInjured(ped, false)
        TaskStartScenarioInPlace(ped, Config.PedAnimation, 0, true)
        SetPedKeepTask(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
    end)

    CreateThread(function()
        exports['qb-target']:AddTargetModel(Config.PedModel, {
            options = {
                {
                    type = "client",
                    event = "p33t-trailers:OpenMenu",
                    icon = Config.TargetIcon,
                    label = Config.TargetLabel
                }
            },
            distance = 3.0
        })
    end)
end

function CreateBlips()
    if Config.ShowBlip == true then
    local blip = AddBlipForCoord(Config.SpawnLocation)
    SetBlipSprite(blip, Config.BlipIconId)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('trlr')
    AddTextEntry('trlr', Config.BlipLabel)
    EndTextCommandSetBlipName(blip)
    end
end

if Config.Debug == true then
    do
        RegisterCommand("debug_respawnped", function()
            DeleteEntity(ped)
            SpawnPed()
        end)
        RegisterCommand("debug_showblip", function() CreateBlips() end)
        RegisterCommand("debug_fetchtrailers", function() FetchTrailers() end)
    end
end

RegisterNetEvent('p33t-trailers:OpenMenu', function()
    DebugPrint("Opening Menu")
    openMenu()
end)

function openMenu()
    local trailerList = {}
    trailerList[#trailerList + 1] = {
        isMenuHeader = true,
        header = Config.TargetLabel,
        icon = Config.TargetIcon
    }
    for k, v in pairs(Config.Trailers) do
        trailerList[#trailerList + 1] =
            { -- insert data from our loop into the menu
                header = v,
                txt = '',
                icon = Config.ItemIcon,
                params = {
                    event = 'p33t:client:renttrailer', -- event name
                    args = {
                        name = k, -- value we want to pass
                        text = v
                    }
                }
            }
    end
    exports['qb-menu']:openMenu(trailerList) -- open our menu
end

AddEventHandler('p33t:client:renttrailer', function(name, text)
    DebugPrint("Renting Trailer with name: " .. name.name)
    -- check if the player has enough money to rent the trailer

    QBCore.Functions.TriggerCallback('p33t-trailers:server:RentCheck',
                                     function(CanRent)
        if CanRent then
            RequestModel(name.name)
            while not HasModelLoaded(name.name) do Wait(1) end
            local vehicle = CreateVehicle(name.name, Config.SpawnLocation.x,
                                          Config.SpawnLocation.y,
                                          Config.SpawnLocation.z,
                                          Config.SpawnLocation.w, true, false)
            DebugPrint("Rented Trailer with name: " .. name.name)
            SendNotification(Config.NotificationOnRent .. name.text)
        else
            SendNotification(Config.OnNoFunds)
        end
    end)
end)

function DebugPrint(msg)
    if Config.Debug == true then print("[p33t-trailers] DEBUG " .. msg) end
end

function SendNotification(text)
    if Config.NotificationType == "qb" then
        TriggerEvent('QBCore:Notify', text, "success", 2000)
    elseif Config.NotificationType == "okok" then
        exports['okokNotify']:SendAlert(text)
    end
end
