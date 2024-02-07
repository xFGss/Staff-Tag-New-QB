local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("checkperms:fordisplay", function(source, cb)
    local player = GetPlayerName(source)

    if player ~= nil then
        local playerPems = false
        if QBCore.Functions.HasPermission(source, 'god') or QBCore.Functions.HasPermission(source, 'admin') or QBCore.Functions.HasPermission(source, 'mod') or IsPlayerAceAllowed(source, 'command') then
            playerPems = true 
            cb(playerPems)
        else
            playerPems = false
            cb(playerPems)
        end
    end
end)

RegisterServerEvent('on:logs')
AddEventHandler('on:logs', function()
    local playerName = GetPlayerName(source)
    PerformHttpRequest("https://discord.com/api/webhooks/1204737836994138152/nP05uk5jGDS_W0Nfb9N68S3ziUSCO178E7JBMgyVxS4tpJRo6zYJH_RYWjCs0ZbA54cA", function(err, text, headers) end, 'POST', json.encode({embeds={{title="Staff Logs",description=" \n**Oνομα STAFF**: "..playerName.."\n**WENT ON**\n**TIME: **"..os.date("!%H:%M",  os.time() + 3 * 60 * 60).."",color=0000}}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('off:logs')
AddEventHandler('off:logs', function()
    local playerName = GetPlayerName(source)
    PerformHttpRequest("https://discord.com/api/webhooks/1204738014782292028/55xQsKOpgBqNE2CxhvqiChSXrq4RHpCpOuMgy2i9yNpbbzmauCV7LDp9GvI5AHw1Kgnt", function(err, text, headers) end, 'POST', json.encode({embeds={{title="Staff Logs",description=" \n**Oνομα STAFF**: "..playerName.."\n**WENT OFF**\n**TIME: **"..os.date("!%H:%M",  os.time() + 3 * 60 * 60).."",color=0000}}}), { ['Content-Type'] = 'application/json' })
end)