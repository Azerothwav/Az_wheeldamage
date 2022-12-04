Config.InitFrameWork()

local WheelAlreadyBroken = {}
local objroue = {}
table.insert(WheelAlreadyBroken, {index = 'none', vehicule = 'none'})

local RouePos = {
    [0] = {bone = 'wheel_lf', props = 'prop_wheel_01'},
    [1] = {bone = 'wheel_rf', props = 'prop_wheel_01'},
    [2] = {bone = 'wheel_lr', props = 'prop_wheel_01'},
    [3] = {bone = 'wheel_rr', props = 'prop_wheel_01'},
}

startcheck = true
local havefind = false
local havefind2 = false
local havefind3 = false
local havefind4 = false
Citizen.CreateThread(function()
    while startcheck do
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local wait = 1000
        if vehicle ~= 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            local classveh = GetVehicleClass(vehicle)
            local classwheel = GetVehicleWheelType(vehicle)
            if classveh == 14 or classveh == 15 or classveh == 16 or classveh == 8 or classwheel == 4 then
            else
                wait = 0
                local roue = GetVehicleNumberOfWheels(vehicle) - 1
                for i = 0, roue, 1 do
                    if tonumber(GetVehicleWheelSuspensionCompression(vehicle, i)) == 0.00 and not injump and GetVehicleWheelXOffset(vehicle, i) ~= '-nan' then
                        injump = true
                        Citizen.SetTimeout(Config.TimeToDetachWheel, function()
                            for k, v in pairs(WheelAlreadyBroken) do
                                if v.index == i then
                                    havefind = true
                                end
                            end
                            if not havefind then
                                ChechIfDetach(vehicle, i)
                            else
                                if i < 3 then
                                    for k, v in pairs(WheelAlreadyBroken) do
                                        if v.index == i + 1 then
                                            havefind2 = true
                                        end
                                    end
                                    if not havefind2 then
                                        ChechIfDetach(vehicle, i + 1)
                                    else
                                        if i < 3 then
                                            for k, v in pairs(WheelAlreadyBroken) do
                                                if v.index == i + 2 then
                                                    havefind3 = true
                                                end
                                            end
                                            if not havefind3 then
                                                ChechIfDetach(vehicle, i + 2)
                                            else
                                                if i < 3 then
                                                    for k, v in pairs(WheelAlreadyBroken) do
                                                        if v.index == i + 3 then
                                                            havefind4 = true
                                                        end
                                                    end
                                                    if not havefind4 then
                                                        ChechIfDetach(vehicle, i + 3)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)
local inchek = false
Citizen.CreateThread(function()
    lastkm = nil
    oldcompteurlaunch = false
    local wait = 1000
    while startcheck do
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if vehicle ~= 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            local classveh = GetVehicleClass(vehicle)
            if classveh == 14 or classveh == 15 or classveh == 16 or classveh == 8 then
            else
                wait = 0
                if not oldcompteurlaunch then
                    oldcompteurlaunch = true
                    Citizen.SetTimeout(1000, function()
                        lastkm = math.ceil(GetEntitySpeed(vehicle) * 3.6)
                        oldcompteurlaunch = false
                    end)
                end
                if lastkm then
                    if HasEntityCollidedWithAnything(vehicle) and lastkm >= Config.KmMax then
                        if not inchek and GetVehicleWheelXOffset(vehicle, i) ~= '-nan' then
                            inchek = true
                            local roue = GetVehicleNumberOfWheels(vehicle) - 1
                            for i = 0, roue, 1 do
                                for k, v in pairs(WheelAlreadyBroken) do
                                    if v.index == i then
                                        havefind = true
                                    end
                                end
                                if not havefind then
                                    ChechIfDetachGround(vehicle, i)
                                else
                                    if i < 3 then
                                        for k, v in pairs(WheelAlreadyBroken) do
                                            if v.index == i + 1 then
                                                havefind2 = true
                                            end
                                        end
                                        if not havefind2 then
                                            ChechIfDetachGround(vehicle, i + 1)
                                        else
                                            if i < 3 then
                                                for k, v in pairs(WheelAlreadyBroken) do
                                                    if v.index == i + 2 then
                                                        havefind3 = true
                                                    end
                                                end
                                                if not havefind3 then
                                                    ChechIfDetachGround(vehicle, i + 2)
                                                else
                                                    if i < 3 then
                                                        for k, v in pairs(WheelAlreadyBroken) do
                                                            if v.index == i + 3 then
                                                                havefind4 = true
                                                            end
                                                        end
                                                        if not havefind4 then
                                                            ChechIfDetachGround(vehicle, i + 3)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

local wheelpickup = false

if Config.CommandFix then
    RegisterCommand("startfix", function()
        for k, v in pairs(WheelAlreadyBroken) do
            local playercoords = GetEntityCoords(GetPlayerPed(-1))
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if vehicle ~= 0 then
                if vehicle == v.vehicule then
                    wheelpickup = true
                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263)
                    AttachEntityToEntity(v.obj, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 135.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                    Config.SendNotification(Config.Lang["StartFixWheel"])
                    Citizen.Wait(5000)
                    startdistancevehiclevar = true
                    Startdistancevehicle(v.vehicule, v.obj, v.index)
                end
            else
                Config.SendNotification(Config.Lang["EnterInVehicleToFix"])
            end
        end
    end, false)
end

if Config.TriggerFix then
    RegisterNetEvent('az_wheel:fixvehicle')
    AddEventHandler('az_wheel:fixvehicle', function()
        for k, v in pairs(WheelAlreadyBroken) do
            local playercoords = GetEntityCoords(GetPlayerPed(-1))
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if vehicle ~= 0 then
                if vehicle == v.vehicule then
                    wheelpickup = true
                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263)
                    AttachEntityToEntity(v.obj, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 135.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                    Config.SendNotification(Config.Lang["StartFixWheel"])
                    Citizen.Wait(5000)
                    startdistancevehiclevar = true
                    Startdistancevehicle(v.vehicule, v.obj, v.index)
                end
            else
                Config.SendNotification(Config.Lang["EnterInVehicleToFix"])
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        for k, v in pairs(WheelAlreadyBroken) do
            local playercoords = GetEntityCoords(GetPlayerPed(-1))
            local coordsroue = GetEntityCoords(v.obj)
            if GetDistanceBetweenCoords(playercoords, coordsroue, true) < 2 then
                wait = 0
                if not wheelpickup then
                    DrawText3Ds(coordsroue.x, coordsroue.y, coordsroue.z + 0.50, Config.Lang["PressToPickWheel"])
                end
                if IsControlJustReleased(0, 38) and not wheelpickup then
                    wheelpickup = true
                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263)
                    AttachEntityToEntity(v.obj, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.0, 0.0, 0.0, 135.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                    startdistancevehiclevar = true
                    Startdistancevehicle(v.vehicule, v.obj, v.index)
                end
            end
        end
        Citizen.Wait(wait)
    end
end)

local sendtoserver = false
function Startdistancevehicle(vehicule, obj, index)
    local wait = 1000
    local draw3dtext = false
    Citizen.CreateThread(function()
        while startdistancevehiclevar do
            local vehiclecoords = GetEntityCoords(vehicule)
            local playercoords = GetEntityCoords(GetPlayerPed(-1))
            local vehicleheading = GetEntityHeading(vehicule)
            if GetDistanceBetweenCoords(playercoords, vehiclecoords, true) < 3 then
                wait = 0
                if not draw3dtext then
                    DrawText3Ds(vehiclecoords.x, vehiclecoords.y, vehiclecoords.z, Config.Lang["PressToFixWheel"])
                end
                if IsControlJustReleased(0, 38) then
                    local findplayerin = false
                    for l = 0, 5, 1 do
                        if GetPedInVehicleSeat(vehicule, l - 1) ~= 0 then
                            findplayerin = true
                        end
                    end
                    if not findplayerin then
                        draw3dtext = true
                        Citizen.SetTimeout(5000, function()
                            sendtoserver = false
                        end)
                        local phantomveh = CreateVehicle(GetHashKey("baller"), vehiclecoords, vehicleheading, false, false)
                        FreezeEntityPosition(phantomveh, true)
                        SetEntityCollision(phantomveh, false, false)
                        SetEntityVisible(phantomveh, false, false)
                        for k, v in pairs(RouePos) do
                            if k == index then
                                local roueposition = GetWorldPositionOfEntityBone(phantomveh, GetEntityBoneIndexByName(phantomveh, v.bone))
                                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
                                Citizen.Wait(Config.TimeToAttachWheel)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                if not sendtoserver then
                                    sendtoserver = true
                                    TriggerServerEvent('az_wheel:updatewheel', VehToNet(vehicule), index, GetVehicleWheelXOffset(phantomveh, index), ObjToNet(obj))
                                end
                                DeleteEntity(phantomveh)
                            end
                        end
                        Citizen.SetTimeout(2500, function()
                            wheelpickup = false
                            if index == 0 then
                                if havefind then
                                    havefind = false
                                end
                            elseif index == 1 then
                                if havefind2 then
                                    havefind2 = false
                                end
                            elseif index == 2 then
                                if havefind3 then
                                    havefind3 = false
                                end
                            elseif index == 3 then
                                if havefind4 then
                                    havefind4 = false
                                end
                            end
                        end)
                        startdistancevehiclevar = false
                    else
                        Config.SendNotification(Config.Lang["PlayerInVeh"])
                    end
                end
            end
            Citizen.Wait(wait)
        end
    end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

function ChechIfDetachGround(vehicle, i)
    if not incooldowncheckground then
        local findwheel = false
        local havefind = false
        local inground = false
        incooldowncheckground = true
        Citizen.SetTimeout(1000, function()
            incooldowncheckground = false
            inchek = false
        end)
        if GetVehicleWheelXOffset(vehicle, i) ~= '-nan' then
            for k, v in pairs(WheelAlreadyBroken) do
                if v.index == i then
                    havefind = true
                end
                if v.obj == objroue[i] then
                    havefind = true
                end
            end
            if not havefind then
                for k, v in pairs(RouePos) do
                    if k == i then
                        if objroue[i] == nil then
                            local roueposition = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v.bone))
                            if not HasModelLoaded(v.props) then
                                RequestModel(v.props)
                                while not HasModelLoaded(v.props) do
                                    Citizen.Wait(1)
                                end
                            end
                            objroue[i] = CreateObject(v.props, roueposition, false)
                            TriggerServerEvent('az_wheel:setoffsetserver', VehToNet(vehicle), i, -math.random(1000, 1025), objroue[i])
                        end
                    end
                end
            else
                if i < 3 then
                    ChechIfDetachGround(vehicle, i + 1)
                end
            end
        end
    end
end

function ChechIfDetach(vehicle, i)
    if not incooldowncheck then
        local havefind = false
        local inground = false
        local hauteur = 0
        incooldowncheck = true
        Citizen.SetTimeout(1000, function()
            incooldowncheck = false
            injump = false
            if inchek then
                inchek = false
            end
        end)
        if tonumber(GetVehicleWheelSuspensionCompression(vehicle, i)) == 0.00 and GetVehicleWheelXOffset(vehicle, i) ~= '-nan' then
            for k, v in pairs(WheelAlreadyBroken) do
                if v.index == i then
                    havefind = true
                end
                if v.obj and v.obj ~= nil then
                    if v.obj == objroue[i] then
                        havefind = true
                    end
                end
            end
            if not havefind then
                while not inground do
                    for n = 0, 4, 1 do
                        hauteur = hauteur + tonumber(GetVehicleWheelSuspensionCompression(vehicle, i))
                        if hauteur > 0 then
                            inground = true
                        end
                    end 
                    Citizen.Wait(0)
                end
                for k, v in pairs(RouePos) do
                    if k == i then
                        if objroue[i] == nil then
                            local roueposition = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, v.bone))
                            if not HasModelLoaded(v.props) then
                                RequestModel(v.props)
                                while not HasModelLoaded(v.props) do
                                    Citizen.Wait(1)
                                end
                            end
                            objroue[i] = CreateObject(v.props, roueposition, false)
                            TriggerServerEvent('az_wheel:setoffsetserver', VehToNet(vehicle), i, -math.random(1000, 1025), objroue[i])
                        end
                    end
                end
            else
                if i < 3 then
                    ChechIfDetach(vehicle, i + 1)
                end
            end
        end
    end
end

RegisterNetEvent('az_wheel:setoffset')
AddEventHandler('az_wheel:setoffset', function(veh, index, offset, obj)
    if index and veh and offset then
        table.insert(WheelAlreadyBroken, {index = index, vehicule = NetToVeh(veh), obj = obj})
        SetVehicleWheelXOffset(NetToVeh(veh), index, offset)
    end
end)

RegisterNetEvent('az_wheel:updatewheelclient')
AddEventHandler('az_wheel:updatewheelclient', function(veh, index, offset, obj)
    if index and veh and offset and obj then
        SetVehicleWheelXOffset(NetToVeh(veh), index, offset)
        for z, w in pairs(WheelAlreadyBroken) do
            if w.obj == obj and w.index == index then
                WheelAlreadyBroken[z] = nil
            end
        end
        DeleteEntity(obj)
        for k, v in pairs(objroue) do
            if v == obj then
                objroue[k] = nil
            end
        end
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if vehicle ~= 0 then
            if #WheelAlreadyBroken > 0 then
                for k, v in pairs(WheelAlreadyBroken) do
                    if v.index and v.index ~= nil and v.vehicule and v.vehicule ~= 'none' then
                        if v.vehicule == vehicle then
                            SetEntityCollision(v.vehicule, true, true)
                            SetVehicleWheelXOffset(v.vehicule, v.index, -math.random(1000, 1025))
                        end
                    end
                end
            end   
        end
        Citizen.Wait(0)
    end
end)