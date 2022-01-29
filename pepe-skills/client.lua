local pedindex = {}

Framework                             = nil
strengthValue = nil
staminaValue = nil
shootingValue = nil
drivingValue = nil
fishingValue = nil
drugsValue = nil
local isOpen = false

---------------------------------
------------- CONFIG ------------
---------------------------------

local openKey = 179 -- replace 142 with what button you want

---------------------------------
---------------------------------

Citizen.CreateThread(function()
    while Framework == nil do
        TriggerEvent('Framework:GetObject', function(obj) Framework = obj end)
        Citizen.Wait(31)
    end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(2)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('pepe-skills:sendPlayerSkills')
AddEventHandler('pepe-skills:sendPlayerSkills', function(stamina, strength, driving, shooting, fishing, drugs)
	strengthValue = strength
	staminaValue = stamina
	shootingValue = shooting
	drivingValue = driving
	fishingValue = fishing
	drugsValue = drugs

	StatSetInt("MP0_STRENGTH", round(strength), true)
	StatSetInt("MP0_STAMINA", round(stamina), true)
	StatSetInt('MP0_LUNG_CAPACITY', round(stamina), true)
	StatSetInt('MP0_SHOOTING_ABILITY', round(shooting), true)
	StatSetInt('MP0_WHEELIE_ABILITY', round(driving), true)
	StatSetInt('MP0_DRIVING_ABILITY', round(driving), true)
end)

--===============================================
--==                 VARIABLES                 ==
--===============================================
function EnableGui(enable)
	Framework.Functions.TriggerCallback('pepe-skills:getSkills', function(stamina, strength, driving, shooting, fishing, drugs)
		strengthValue = strength
		staminaValue = stamina
		shootingValue = shooting
		drivingValue = driving
		fishingValue = fishing
		drugsValue = drugs

		SendNUIMessage({
			type = "enableui",
			enable = enable,
			stamina = staminaValue,
			strength = strengthValue,
			driving = drivingValue,
			shooting = shootingValue,
			fishing = fishingValue, 
			drugs = drugsValue
		})
	end)
end

--===============================================
--==              Close GUI                    ==
--===============================================

Faketimer = 0


Citizen.CreateThread(function()

	while true do

        if IsDisabledControlJustReleased(17, 11) and isOpen == false then
			isOpen = true
			EnableGui(true)
		elseif IsDisabledControlJustReleased(17, 11) and isOpen == true then
			isOpen = false
			EnableGui(false)
		end

        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
          if Faketimer >= 10 then
            TriggerServerEvent('pepe-skills:addDriving', GetPlayerServerId(PlayerId()), (math.random() + 0))
            Faketimer = 0
          end
        end
        if Faketimer >= 180 then
          Faketimer = 0
        end
        Citizen.Wait(0)
    end
	
end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
    Faketimer = Faketimer + 1 
	end 
end)