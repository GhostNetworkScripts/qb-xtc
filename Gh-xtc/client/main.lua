local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local xtcpicking = false
local xtcprocess = false
local nearDealer = false
local QBCore = exports['qb-core']:GetCoreObject()


DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(-601.58, -1602.72, 30.41))
 --        local distance2 = #(PlayerPos - vector3(YOUR COORDS HERE)) -- YOUR COORDS HERE
 --        local distance3 = #(PlayerPos - vector3(YOUR COORDS HERE)) -- YOUR COORDS HERE
        
        if distance < 6 then
            inRange = true

            if distance < 2 then
                DrawText3Ds(-601.58, -1602.72, 30.41, "~g~E~w~ Process Xtc")
                if IsControlJustPressed(0, 38) then
					TriggerServerEvent("Gh-xtc:server:processxtc")
                end
            end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

-- uncomment if you want use sell for xtc 

-- Citizen.CreateThread(function()
--     while true do
--         local inRange = false

--         local PlayerPed = PlayerPedId()
--         local PlayerPos = GetEntityCoords(PlayerPed)

--         local distance = #(PlayerPos - vector3(974.08, -192.22, 73.2))
        
--         if distance < 6 then
--             inRange = true

--             if distance < 2 then
--                 DrawText3Ds(974.08, -192.22, 73.2, "~g~E~w~ Sell xtc")
--                 if IsControlJustPressed(0, 38) then
--                     TriggerServerEvent("Gh-xtc:server:xtcsell")

--                 end
--             end
            
--         end

--         if not inRange then
--             Citizen.Wait(2000)
--         end
--         Citizen.Wait(3)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance1 = #(PlayerPos - vector3(2145.43, 4777.14, 40.97))
        local distance2 = #(PlayerPos - vector3(2146.62, 4775.18, 41.02))
        local distance3 = #(PlayerPos - vector3(2138.16, 4771.28, 41.02))
        local distance4 = #(PlayerPos - vector3(2132.78, 4768.81, 41.01))
        
        if distance1 < 15 then
            inRange = true

            if distance1 < 2 then
                DrawText3Ds(2145.43, 4777.14, 40.97, "~g~E~w~ Take ingredients")
                if IsControlJustPressed(0, 38) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			
            if distance2 < 2 then
                DrawText3Ds(2146.62, 4775.18, 41.02, "~g~E~w~ Take ingredients")
                if IsControlJustPressed(0, 38) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			

            if distance3 < 2 then
                DrawText3Ds(2138.16, 4771.28, 41.02, "~g~E~w~ Take ingredients")
                if IsControlJustPressed(0, 38) then
                    PrepareAnim()
                    pickProcess()
                end
            end

            if distance4 < 2 then
                DrawText3Ds(2132.78, 4768.81, 41.01, "~g~E~w~ Take ingredients")
                if IsControlJustPressed(0, 38) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent('Gh-xtc:client:pickxtc')
AddEventHandler('Gh-xtc:client:pickxtc', function(source)
    PrepareAnim()
    pickProcess()
end)


RegisterNetEvent('Gh-xtc:client:xtcprocess')
AddEventHandler('Gh-xtc:client:xtcprocess', function(source)
	PrepareAnim()
    xtcProcess()
end)

function pickProcess()
    QBCore.Functions.Progressbar("pick_xtc", "Picking Xtc ingredients...", math.random(5000,7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("Gh-xtc:server:getxtci")
        ClearPedTasks(PlayerPedId())
        xtcspicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function xtcProcess()
    QBCore.Functions.Progressbar("xtc_process", "Process xtc...", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("Gh-xtc:server:getxtc")
        ClearPedTasks(PlayerPedId())
        xtcspicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Canceled", "error")
    end)
end

function PickMinigame()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject() -- Replace if you use other skillbar script
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
    end

    local maxwidth = 30
    local maxduration = 3500

    Skillbar.Start({
        duration = math.random(2000, 3000),
        pos = math.random(10, 30),
        width = math.random(20, 30),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            pickProcess()
            QBCore.Functions.Notify("You picked xtc ingredients", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(2000, 3000),
                pos = math.random(10, 30),
                width = math.random(20, 30),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up xtc ingredients!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            xtcspicking = false
       
    end)
end

function ProcessMinigame(source)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()-- Replace with other if you have other script
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
    end

    local maxwidth = 30
    local maxduration = 3000

    Skillbar.Start({
        duration = math.random(2000, 3000),
        pos = math.random(10, 30),
        width = math.random(20, 30),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            xtcprocess()
            QBCore.Functions.Notify("You make some xtc!", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(2000, 3000),
                pos = math.random(10, 30),
                width = math.random(20, 30),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up the xtc Process!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            xtcprocess = false
       
    end)
end


function PrepareAnim()
    local ped = PlayerPedId()
    LoadAnim('mini@repair')
    TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    PreparingAnimCheck()
end

function PreparingAnimCheck()
    xtcProcess = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if xtcprocess then
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function PrepareAnim()
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_PARKING_METER", 0, false)
    PreparingAnimCheck()
end

function xtcProcessPrepareAnim()
    local ped = PlayerPedId()
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    PreparingAnimCheck()
end

function PreparingAnimCheck()
    xtcspicking = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if xtcspicking then
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end
