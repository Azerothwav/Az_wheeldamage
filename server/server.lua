RegisterNetEvent('az_wheel:updatewheel')
AddEventHandler('az_wheel:updatewheel', function(veh, index, offset, obj)
    TriggerClientEvent('az_wheel:updatewheelclient', -1, veh, index, offset, obj)
end)

RegisterNetEvent('az_wheel:setoffsetserver')
AddEventHandler('az_wheel:setoffsetserver', function(veh, index, offset, obj)
    TriggerClientEvent('az_wheel:setoffset', -1, veh, index, offset, obj)
end)