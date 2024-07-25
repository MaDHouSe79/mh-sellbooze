local QBCore = exports['qb-core']:GetCoreObject()

local function SellAllItems(id)
    local Player = QBCore.Functions.GetPlayer(id)
    local hasSell = false
    if Player then
        for _, data in pairs(Config.BuyingItems) do
            local items = exports['qb-inventory']:GetItemsByName(id, data.name)
            if items ~= nil then
                for _, item in pairs(items) do
                    if item.name == data.name then
                        hasSell = true
                        Player.Functions.AddMoney('cash', data.buy_price * item.amount)
                        Player.Functions.RemoveItem(data.name, item.amount, item.slot)
                        TriggerClientEvent('qb-inventory:client:ItemBox', id, QBCore.Shared.Items[data.name], 'remove', item.amount)
                        TriggerClientEvent("QBCore:Notify", id, Lang:t('notify.you_sell_all_items'))
                    end
                end               
            end
        end
        if not hasSell then
            TriggerClientEvent("QBCore:Notify", id, Lang:t('notify.no_items_to_sell'))
        end
    end
end

RegisterServerEvent('mh-sellbooze:server:SellAllItems', function()
    local src = source
    SellAllItems(src)
end)

RegisterNetEvent('mh-sellbooze:server:SellItemMenu', function()
    local src = source
    TriggerClientEvent('mh-sellbooze:server:SellItemMenu', src)
end)
