local CombinedPolyzones
local Zones = {}
local CurrentInteractZone = {}

function ComboZoneAdd(polyzone)
    if polyzone == nil then return print("zone was nil!") end
    if CombinedPolyzones == nil then
        CombinedPolyzones = ComboZone:Create({polyzone}, {name = Config.ComboZoneName })
        CombinedPolyzones:onPointInOutExhaustive(Config.ReturnFunction,function(isPointInside, point, insideZones, enteredZones, leftZones)
            if enteredZones and isPointInside then
                for _,v in ipairs(enteredZones) do
                    if Config.Debug  then
                        print("Entering")
                        print("ID: "..v.data.group )
                        print("Name: "..v.name)
                        --TriggerEvent('table',v) -- if your using cd_devtools uncomment this!
                    end
                    CurrentInteractZone[v.name] = v
                    if Config.TriggerEvents then
                        TriggerEvent(Config.EventName..':Enter',v)
                    end
                end
            end
            if leftZones and not isPointInside then
                for _,v in ipairs(leftZones) do
                    CurrentInteractZone[v.name] = nil
                    print("Exiting")
                    print("ID: "..v.data.group )
                    print("Name: "..v.name)
                    if Config.TriggerEvents then
                        TriggerEvent(Config.EventName..':Exit',v)
                    end
                end
            end
        end,Config.WaitTime)
    else
        CombinedPolyzones:AddZone(polyzone)
    end
end

function CreateBoxZone(group,coords,length,width,options)

    if group == nil or type(group) ~= 'string' then return end
    if coords == nil or type(coords) ~= 'vector3' then  return end
    if length == nil or type(length) ~= 'number' then return end
    if width == nil or type(width) ~= 'number' then return end
    if options == nil then print('boxzone group: '..group..' without options!') return end
    if options.name == nil then print("boxzone without name") return end


    options.data = {}
    options.data.group = group

    if not Zones[group] then
        Zones[group] = {}
        Zones[group][options.name] = true
    elseif not Zones[group][options.name] then
        Zones[group][options.name] = true
    else
        print("boxzone with the name: "..options.name..' and group: '..group..' already exists')
        return
    end

    local boxzone = BoxZone:Create(coords,length,width,options)

    ComboZoneAdd(boxzone)
end

function CreateCircleZone(group,coords,radius,options)

    if group == nil or type(group) ~= 'string' then return end
    if coords == nil or type(coords) ~= 'vector3' then  return end
    if radius == nil or type(radius) ~= 'number' then return end
    if options == nil then print('circleZone group: '..group..' without options!') return end
    if options.name == nil then print("circleZone without name") return end


    options.data = {}
    options.data.group = group

    if not Zones[group] then
        Zones[group] = {}
        Zones[group][options.name] = true
    elseif not Zones[group][options.name] then
        Zones[group][options.name] = true
    else
        print("circleZone with the name: "..options.name..' and group: '..group..' already exists')
        return
    end

    local circleZone = CircleZone:Create(coords,radius,options)

    ComboZoneAdd(circleZone)
end

function CreatePolyZone(group,coords,options)

    if group == nil or type(group) ~= 'string' then return end
    if coords == nil or type(coords) ~= 'table' then  return end
    if options == nil then print('polyZone group: '..group..' without options!') return end
    if options.name == nil then print("polyZone without name") return end


    options.data = {}
    options.data.group = group

    if not Zones[group] then
        Zones[group] = {}
        Zones[group][options.name] = true
    elseif not Zones[group][options.name] then
        Zones[group][options.name] = true
    else
        print("polyZone with the name: "..options.name..' and group: '..group..' already exists')
        return
    end

    local polyZone = PolyZone:Create(coords,options)

    ComboZoneAdd(polyZone)
end


-- Massive thanks to mkafrin for making this function possible! Hes a legend!
function ComboZoneRemove(polyzone,isGroup,removeAllChildren)
    if CombinedPolyzones ~= nil then
        if isGroup == true then
            if Zones[polyzone] ~= nil then
                if removeAllChildren == true then
                    for k,_ in pairs(Zones[polyzone]) do
                        CombinedPolyzones:RemoveZone(function (zone) return zone.name == k end)
                    end
                else
                    CombinedPolyzones:RemoveZone(function (zone) return zone.data.name == polyzone end)
                end
            end
        else
            CombinedPolyzones:RemoveZone(function (zone) return zone.name == polyzone end)
        end
    end
end


exports("CreateBoxZone", CreateBoxZone)
exports("CreateCircleZone", CreateCircleZone)
exports("CreatePolyZone", CreatePolyZone)
exports("ComboZoneRemove", ComboZoneRemove)

-- you can use these exports in any script you like. if you are wanting to make polyzones use this link or the inbuilt
-- creation script from the polyzone resource. https://skyrossm.github.io/PolyZoneCreator/.
-- for circle or box zones i recommend the inbuilt creation script!


CreateBoxZone("Police:Duty",vector3(441.79, -982.07, 30.69), 0.4, 0.6, {
    name        =   "Police:Duty",
    heading     =   91,
    minZ        =   30.79,
    maxZ        =   30.99
})
CreateCircleZone("Police:Duty",vector3(441.79, -980.07, 30.69), 0.6, {
    name        =  "Police:Duty2",
    heading     =   91,
    minZ        =   30.79,
    maxZ        =   30.99
})

CreatePolyZone("Police:Duty",{
    vector2(432.58, -1024.24),
    vector2(415.91, -1057.20),
    vector2(370.83, -1036.36),
    vector2(378.79, -1014.02),
    vector2(401.14, -997.35)
},{
    name="Police:Duty3",
    heading=345,
    minZ=28.31,
    maxZ=33.31
})

-- the format is inspired by bt-polyzone. The group of the polyzone can be used multiple times like shown above

--ComboZoneRemove("Police:Duty" false false)
--the example above would only remove the FIRST polyzone and no others.

--ComboZoneRemove("Police:Duty" true false)
--the example above would only remove the first Zone inside of the Police:Duty group

--ComboZoneRemove("Police:Duty" true true)
--the example above would remove ALL of the zones within the group Police:Duty.



----------------------------
---- DEBUG FUNCTIONS -------
----------------------------
if Config.Debug then
    local toggle = false

    RegisterCommand('combodraw',function()
        toggle = not toggle
        while toggle do
            CombinedPolyzones:draw()
            Wait(0)
        end
    end)

    -- will make the polyzone resource draw walls where your zone is

    RegisterCommand('comboinfo',function()
        CombinedPolyzones:printInfo()
    end)

    -- lists info about your combozone such as the name and amount of zones currently created
    if Config.RemoveZonesOnStop then
        AddEventHandler('onResourceStop', function(resourceName)
            if (GetCurrentResourceName() ~= resourceName) then
                return
            end
            print(resourceName.." destroyed its zones on resource stop!")
            CombinedPolyzones:destroy()
        end)
        -- this just prevents zones from staying if the resource is restarted. This can be disabled in the config!
    end
end




