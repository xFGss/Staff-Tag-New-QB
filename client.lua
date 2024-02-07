local QBCore = exports['qb-core']:GetCoreObject()

local activated = false

function DrawTextBody(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    --SetTextScale(0.0*scale, 0.55*scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.3)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

RegisterCommand('sduty', function()
    QBCore.Functions.TriggerCallback("checkperms:fordisplay", function(permschecked, player)
        if permschecked == true then 
            if activated == false then
                TriggerServerEvent('on:logs')
            end
            activated = true
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local offset = 1
                    local Mycoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local coords = GetEntityCoords(PlayerPedId(), false)
                    local dist = Vdist2(Mycoords, coords)
                    if dist < 5 then
                        if activated == true then
                            local Player = QBCore.Functions.GetPlayerData()
                            DrawTextBody(Mycoords.x,  Mycoords.y,  Mycoords.z + 1, "~b~~h~[STAFF]~h~~s~¦\n"..GetPlayerName(PlayerId()))
                        end
                    end
                end
            end)
            exports['okokNotify']:Alert("STAFF", "Tag ativada", 3000, 'success')
        else
            exports['okokNotify']:Alert("STAFF", "Não tens permissão para usar este comando", 3000, 'error')
        end
    end)
end)


RegisterCommand('offduty', function()
    QBCore.Functions.TriggerCallback("checkperms:fordisplay", function(permschecked)
        if permschecked == true then 
            activated = false
            exports['okokNotify']:Alert("STAFF", "Tag desativada", 3000, 'success')
        else
            exports['okokNotify']:Alert("STAFF", "Não tens permissão para usar este comando", 3000, 'error')
        end 
    end)
    if activated == true then
        TriggerServerEvent('off:logs')
    end
end)