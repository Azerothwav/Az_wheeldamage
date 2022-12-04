Config = {}

Config.FrameWork = "ESX"

Config.TriggerFix = false
Config.CommandFix = true

Config.TimeToDetachWheel = 1000
Config.TimeToAttachWheel = 5000
Config.KmMax = 200

Config.Lang = {
    ["StartFixWheel"] = 'Repair of the wheels thrown, please exit the vehicle',
    ["EnterInVehicleToFix"] = 'No vehicle found, please enter the vehicle to be repaired',
    ["PressToPickWheel"] = 'Press E to pick up the wheel',
    ["PressToFixWheel"] = 'Press E to fix the wheel',
    ["PlayerInVeh"] = 'There is someone in the vehicle'
}

Config.SendNotification = function(msg)
    if Config.FrameWork == "ESX" then
        ESX.ShowNotification(msg)
    elseif Config.FrameWork == "QBCore" then
        QBCore.Functions.Notify(msg, 'success')
    elseif Config.FrameWork == "custom" then
        print(msg)
    end
end

Config.InitFrameWork = function()
    if Config.FrameWork == "ESX" then
        ESX = nil TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    elseif Config.FrameWork == "QBCore" then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif Config.FrameWork == "custom" then
        
    end
end