local QBCore = exports['qb-core']:GetCoreObject()


local ItemList = {
    ["xtcbaggy"] = "xtcbaggy"
}

local DrugList = {
    ["xtci"] = "xtci" -- If you add lines add , after the line! 
    --["itemnamehere"] = "itemnamehere", -- Add it like this and its wil works
}


RegisterServerEvent('Gh-xtc:server:processxtc')
AddEventHandler('Gh-xtc:server:processxtc', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName('xtci')

        if Player.PlayerData.items ~= nil then 
            if cannabis ~= nil then 
                if cannabis.amount >= 2 then 

                    Player.Functions.RemoveItem("xtci", 2, false)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['xtci'], "remove")

                    TriggerClientEvent("Gh-xtc:client:xtcprocess", src)
                else
                    TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')   
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')   
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You Have Nothing...", "error")
        end
        
end)


RegisterServerEvent('Gh-xtc:server:xtcsell')
AddEventHandler('Gh-xtc:server:xtcsell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weed = Player.Functions.GetItemByName('xtcbaggy')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if weed ~= nil then
                if DrugList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "xtcbaggy" and Player.PlayerData.items[k].amount >= 1 then 
                        local random = math.random(50, 65)
                        local amount = Player.PlayerData.items[k].amount * random

                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Damn you got '..Player.PlayerData.items[k].amount..'xtc baggy')
                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Ill buy all of it for $'..amount )

                        Player.Functions.RemoveItem("xtcbaggy", Player.PlayerData.items[k].amount)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['xtcbaggy'], "remove")
                        Player.Functions.AddMoney("cash", amount)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You do not have xtc baggy", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have xtc baggy", 'error')
                break
            end
        end
    end
end)


RegisterServerEvent('Gh-xtc:server:getxtci')
AddEventHandler('Gh-xtc:server:getxtci', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("xtci", math.random(1, 6))
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['xtci'], "add")
end)

RegisterServerEvent('Gh-xtc:server:getxtc')
AddEventHandler('Gh-xtc:server:getxtc', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("xtcbaggy", math.random(1, 6))
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['xtcbaggy'], "add")
end)
-- RegisterServerEvent('Gh-xtc:server:getxtc') -- Dont use this one this will give you xtcbaggy on the picking zone! You can change if you like 
-- AddEventHandler('Gh-xtc:server:getxtc', function()
--     local Player = QBCore.Functions.GetPlayer(source)
--     Player.Functions.AddItem("xtcbaggy", math.random(1, 3))
--     TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['xtcbaggy'], "add")
-- end)


--Add more Weed here

-- RegisterServerEvent('Gh-xtc:server:getxtc')
-- AddEventHandler('Gh-xtc:server:getxtc', function()
--     local Player = QBCore.Functions.GetPlayer(source)
--     Player.Functions.AddItem("itemnamehere", 2) ---Name change of the item and amount
--     TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['itemnamehere'], "add") -- change this too!
-- end)
print("^5Xtc Script by Ghostnetwork Loaded!")
print("^2Xtc Script Anti-cheat Loaded!")

