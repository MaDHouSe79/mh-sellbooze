local QBCore = exports['qb-core']:GetCoreObject()
local ShopPed = {}
local listen1 = false
local pedSpawned = false

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
end

local function deletePeds()
    if pedSpawned then
        for k, v in pairs(ShopPed) do
            DeletePed(v)
        end
    end
end

local function Listen4ItemSellControl()
    CreateThread(function()
        listen1 = true
        while listen1 do
            if IsControlJustPressed(0, 38) then -- E
                if inSellItems then
                    exports["qb-core"]:KeyPressed()
                    TriggerServerEvent("mh-sellbooze:server:SellItemMenu")
                end
                listen1 = false
                break
            end
            Wait(1)
        end
    end)
end

local function createPeds()
    if not ShopPed["sellitems"] then ShopPed["sellitems"] = {} end
    for k, v in pairs(Config.SellLocations) do
        local current = GetHashKey(v.ped)
        loadModel(current)
        ShopPed["sellitems"] = CreatePed(0, current, v.coords["x"], v.coords["y"], v.coords["z"] - 1, v.coords.w, false, false)
        TaskStartScenarioInPlace(ShopPed["sellitems"], v.scenario, true)
        FreezeEntityPosition(ShopPed["sellitems"], true)    
        SetEntityInvincible(ShopPed["sellitems"], true)
        SetBlockingOfNonTemporaryEvents(ShopPed["sellitems"], true)
        exports['qb-target']:AddTargetEntity(ShopPed["sellitems"], {
            options = {
                {
                    label = Lang:t('target.sell_items'),
                    icon = 'fa-solid fa-coins',
                    action = function()
                        TriggerServerEvent("mh-sellbooze:server:SellAllItems")
                    end
                }
            },
            distance = 2.0
        })
    end
    pedSpawned = true
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        createPeds()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
    end
end)