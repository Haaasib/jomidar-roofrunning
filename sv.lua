local QBCore = exports['qb-core']:GetCoreObject()

local lastHeistTime = 0 


QBCore.Functions.CreateCallback('jomidar-rr:sv:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    local currentTime = os.time()
    local timeSinceLastHeist = currentTime - lastHeistTime
    
    if timeSinceLastHeist < Config.CoolDown  and lastHeistTime ~= 0 then
        local secondsRemaining = Config.CoolDown  - timeSinceLastHeist
        TriggerClientEvent('QBCore:Notify', src, "You must wait " .. secondsRemaining .. " seconds before starting another work.", "error")
        cb(false)
    else
        lastHeistTime = currentTime
        cb(true)
    end
end)
RegisterNetEvent('jomidar-rr:sv:start')
AddEventHandler('jomidar-rr:sv:start', function()
    TriggerClientEvent('jomidar-rr:start', source)
end)


RegisterNetEvent('jomidar:handleItemSpawn', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        -- Randomly select one item from the list
        local itemIndex = math.random(#Config.RoofRunning["Items"])
        local itemInfo = Config.RoofRunning["Items"][itemIndex]
        
        -- Add the randomly selected item to the player's inventory
        player.Functions.AddItem(itemInfo.item, itemInfo.amount)
        TriggerClientEvent('QBCore:Notify', src, "You have received " .. itemInfo.amount .. "x " .. itemInfo.item, "success")
    else
        print("Player not found on server.")
    end
end)

