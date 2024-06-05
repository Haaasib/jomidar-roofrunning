local QBCore = exports['qb-core']:GetCoreObject()

local zones = {}


function createVisualZone(position, zoneId)
    local zone = {}
    local blip = AddBlipForRadius(position.x, position.y, position.z, 50.0)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 128)
    zone.blip = blip
    zones[zoneId] = zone  
    return zone
end

CreateThread(function()
    while true do
        Wait(0)
        for _, zone in ipairs(zones) do
            DrawMarker(1, zone.position.x, zone.position.y, zone.position.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zone.size.x, zone.size.y, zone.size.z, zone.color.r, zone.color.g, zone.color.b, zone.color.a, false, false, 2, false, nil, nil, false)
        end
    end
end)

function removeVisualZone(zoneId)
    if zones[zoneId] then
        RemoveBlip(zones[zoneId].blip)  -- Remove the blip associated with the zone
        zones[zoneId] = nil             -- Clear the entry from the zones table
    else
        print("Zone with ID " .. zoneId .. " does not exist.")
    end
end


function spawnProps()
    for _, prop in pairs(Config.RoofRunning["acprops"]) do
        local model = GetHashKey(prop.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        -- Set the last parameter to false to make the object static
        local obj = CreateObject(model, prop.coords.x, prop.coords.y, prop.coords.z, false, false, false)
        SetModelAsNoLongerNeeded(model)

        -- Freeze the object to ensure it cannot move
        FreezeEntityPosition(obj, true)
        PlaceObjectOnGroundProperly(obj)

        createTextUIOnProp(obj)
        table.insert(Config.spawnedProps, obj)
    end
end

function createTextUIOnProp(entity)
    exports['j-textui']:create3DTextUIOnEntity(entity, {
        displayDist = 3.0,
        interactDist = 1.0,
        enableKeyClick = true,
        keyNum = 38,
        key = "E",
        text = "Remove AC",
        theme = "green",
        triggerData = {
            triggerName = "jomidar-rr:cl:start",
            args = {entity = entity}
        }
    })
end


function deleteAllProps()
    for _, prop in ipairs(Config.spawnedProps) do
        if DoesEntityExist(prop) then
            FreezeEntityPosition(prop, false)  -- Unfreeze if needed in future
            deleteTextUIFromProp(prop)
            DeleteObject(prop)
        end
    end
    Config.spawnedProps = {}
end


RegisterNetEvent('jomidar-rr:stop')
AddEventHandler('jomidar-rr:stop', function()
        removeVisualZone("centralZone")
        SendNUIMessage({showUI = false; })
end)
RegisterNetEvent('jomidar-rr:pickup')
AddEventHandler('jomidar-rr:pickup', function()
       TriggerServerEvent('jomidar-rr:sv:startpickup')
end)

RegisterNetEvent('jomidar-rr:start')
AddEventHandler('jomidar-rr:start', function()
    QBCore.Functions.TriggerCallback('jomidar-rr:sv:checkTime', function(time)
        if time then
            spawnProps()
            local zoneId = "centralZone" 
            createVisualZone(vector3(-588.79, -276.88, 51.4), zoneId)
            SendNUIMessage({showUI = true; }) -- Sends a message to the js file. 
        end
    end)
end)


RegisterNetEvent('jomidar-rr:cl:start')
AddEventHandler('jomidar-rr:cl:start', function(data)
    local entity = data.entity
    local player = source  -- Assuming this script is running server-side, 'source' represents the player's server ID.
    
    if DoesEntityExist(entity) then
        -- Start the skill check game
        exports['skillchecks']:startSameGame(Config.MiniTime , Config.Gridx, Config.Gridy , function(success)
            if success then
                QBCore.Functions.Progressbar("remove_ac", "Steal Ac Part..", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "mini@repair",
                    anim = "fixing_a_ped",
                    flags = 49,
                }, {}, {}, function()
                    -- Done with progress bar
                    if DoesEntityExist(entity) then
                        -- Remove the 3D text UI from the prop
                        deleteTextUIFromProp(entity)
                        -- Delete the prop
                        DeleteObject(entity)
                        -- Success notification
                        QBCore.Functions.Notify("AC Part successfully removed!", "success", 5000)
                        TriggerServerEvent('jomidar:handleItemSpawn')
                        removeVisualZone("centralZone")
                        SendNUIMessage({
                            showUI = true,
                        })
                    end
                end, function()
                    -- Cancelled progress bar
                    QBCore.Functions.Notify("Failed to remove AC Part. Try again!", "error", 5000)
                end)
            else
                -- Error notification
                QBCore.Functions.Notify("Failed To Breach The Security System. Try again!", "error", 5000)
            end
        end)
    end
end)


function deleteTextUIFromProp(entity)
    exports['j-textui']:delete3DTextUI(entity)
end



AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deleteAllProps()
    end
end)
