Config = {}
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

Config.PedModel = "A_M_M_BevHills_02"
Config.PedAnimation = "WORLD_HUMAN_AA_COFFEE"
Config.PedLocation = vector4(102.34, -1815.77, 25.52, 213.73)
Config.SpawnLocation = vector4(99.84, -1829.7, 25.92, 315.98)
Config.BlipIconId = 479
Config.BlipLabel = "Trailer rent"
Config.TargetIcon = "fas fa-car" -- is used also in the menu -- https://fontawesome.com/v5/search?m=free
Config.ItemIcon = "fas fa-trailer" --https://fontawesome.com/v5/search?m=free
Config.TargetLabel = "Trailer Rent" -- is used also in the menu -- https://fontawesome.com/v5/search?m=free
Config.ShowBlip = true 
Config.Debug = false
Config.NotificationType = "qb" -- "qb" = Basic qb notification, "okok" = okokNotify notification (must have installed)
Config.NotificationOnRent = "You have rented a " -- after this text it will show the trailer name
Config.TrailerPrice = 500
Config.TransactionReason = "Trailer Rent" -- will show in logs
Config.OnNoFunds = "You don't have enough money!" -- notification when you don't have enough money

-- Trailers
Config.Trailers = { -- ['spawn code'] = 'Name that will show in menu'
['boattrailer'] = 'Boat trailer',
['trailersmall'] = 'Small trailer',
}

-- For support, join our discord: https://p33t.net/discord