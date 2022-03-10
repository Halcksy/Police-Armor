ESX                           = nil
local PlayerData = {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10000)
	end

	PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
end)


Citizen.CreateThread(function()
	while true do
		Wait(10)

local player = PlayerPedId()
local playerCoords = GetEntityCoords(player)



local armor = GetPedArmour(player)


for k,v in ipairs(Config.Zone) do
    local distance = #(playerCoords - v)
    if PlayerData.job ~= nil and PlayerData.job.name == Config.job or PlayerData.job ~= nil and PlayerData.job.name == Config.job2 then 
        if distance <= 3 then
    if distance <= 1.0 and  IsControlPressed(0, 38) then
      
        
        TriggerEvent("mythic_progbar:client:progress", {
            name = "vest-wearing",
            duration = 5000,
            label = _U('armor_wearing'),
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "clothingshirt",
                anim = "try_shirt_positive_d",
            },
        }, function(status)
            if not status then
                if armor >= Config.ArmorAmount then
                    ESX.ShowNotification(_U('armor_max'))
            else
               SetPedArmour(player, Config.ArmorAmount)
            end
            end
        end)

    end
   end
end
 end
end
end)



local v1 = vector3(436.3, -993, 30.7)


function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 20
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(0, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local distance_until_text_disappears = 10

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < distance_until_text_disappears then
                Draw3DText(v1.x, v1.y, v1.z, 1.5, "~b~Press ~g~[E]~b~ To Add Vest")
            end
        end
    end
)

