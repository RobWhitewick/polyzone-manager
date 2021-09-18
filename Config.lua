Config = {}

Config.TriggerEvent = false
Config.EventName = 'PManager'-- the name of the events that are triggered when entering/exiting
Config.ComboZoneName = 'polyzoneManager'-- this needs to be set!

Config.Debug = true
Config.RemoveZonesOnStop = true --this just prevents zones from staying after the resource is restarted.

Config.WaitTime = 300
Config.ReturnFunction = function() return GetEntityCoords(PlayerPedId()) end
-- This can be changed to anything that returns a vector3. Another use could be for a interact system using raycasts
-- you can plop qTargets RaycastCamera function in and it will work! (with a few tweaks to the function!)
-- more info here! https://github.com/mkafrin/PolyZone/wiki/ComboZone


-- To more easily read the data returned in the event I recommend using cd_devtools to look at the data it sends over.
-- example zone:  https://i.imgur.com/cWb8FiA.png