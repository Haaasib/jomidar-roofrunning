local QBCore = exports['qb-core']:GetCoreObject()

local lastHeistTime = 0 

function GetPoliceCount()
    local policeCount = 0
    for _, playerId in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData.job.name == 'police' then
            policeCount = policeCount + 1
        end
    end
    return policeCount
end

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
    local source = source
    local policeCount = GetPoliceCount()
    
    if Config.Police == 0 or policeCount >= Config.Police then
        TriggerClientEvent('jomidar-rr:start', source)
    else
        -- Notify the player who triggered the event that there are not enough police officers online
        TriggerClientEvent('QBCore:Notify', source, "Not enough police officers online.", "error")
    end
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

if Config.CheckForUpdates then
    local function VersionLog(_type, log)
        local color = _type == 'success' and '^2' or '^1'
        print(('^8[J0M1D4R]%s %s^7'):format(color, log))
    end

    local function UpdateLog(log)
        print(('^8[J0M1D4R]^3 [Update Log] %s^7'):format(log))
    end

    local function FetchUpdateLog()
        PerformHttpRequest('https://raw.githubusercontent.com/Haaasib/updates/main/rr-update-log.txt', function(err, text, headers)
            if not text then
                UpdateLog('Currently unable to fetch the update log.')
                return
            end
            UpdateLog(':\n' .. text)
        end)
    end

    local function CheckMenuVersion()
        PerformHttpRequest('https://raw.githubusercontent.com/Haaasib/updates/main/rr.txt', function(err, text, headers)
            local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
            if not text then
                VersionLog('error', 'Currently unable to run a version check.')
                return
            end
            VersionLog('success', ('Current Version: %s'):format(currentVersion))
            VersionLog('success', ('Latest Version: %s'):format(text))
            if text:gsub("%s+", "") == currentVersion:gsub("%s+", "") then
                VersionLog('success', 'You are running the latest version.')
            else
                VersionLog('error', ('You are currently running an outdated version, please update to version %s'):format(text))
                FetchUpdateLog()
            end
        end)
    end

    CheckMenuVersion()
end


