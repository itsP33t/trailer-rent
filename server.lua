--[[
 /$$$$$$$   /$$$$$$   /$$$$$$    /$$    
| $$__  $$ /$$__  $$ /$$__  $$  | $$    
| $$  \ $$|__/  \ $$|__/  \ $$ /$$$$$$  
| $$$$$$$/   /$$$$$/   /$$$$$/|_  $$_/  
| $$____/   |___  $$  |___  $$  | $$    
| $$       /$$  \ $$ /$$  \ $$  | $$ /$$
| $$      |  $$$$$$/|  $$$$$$/  |  $$$$/
|__/       \______/  \______/    \___/  
            P33t.tebex.io
--]]

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('p33t-trailers:server:RentCheck', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
   
    if Player.Functions.RemoveMoney('bank', Config.TrailerPrice, Config.TransactionReason) then
        cb(true)
    else
        cb(false)
    end
  end)