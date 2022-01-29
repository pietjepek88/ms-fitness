Framework = nil
Framework = exports["pepe-core"]:GetCoreObject()

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('Framework:Client:OnPlayerLoaded')
AddEventHandler('Framework:Client:OnPlayerLoaded', function(source) 
  local Player = Framework.Functions.GetPlayer(source)
  local _source = source
  exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('pepe-skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
			else
				Framework.Functions.InsertSql(true, "INSERT INTO `pepe-skills` (`identifier`, `strength`, `stamina`, `driving`, `shooting`, `fishing`, `drugs`) VALUES (@identifier, @strength, @stamina, @driving, @shooting, @fishing, @drugs)",
				{
				['@identifier'] = Player.PlayerData.citizenid,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@driving'] = 0,
				['@shooting'] = 0,
				['@fishing'] = 0,
				['@drugs'] = 0,
				})
		end
	end)
end)

function updatePlayerInfo(source)
  local _source = source
  local Player = Framework.Functions.GetPlayer(source)
  exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('pepe-skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
		end
	end)
end

RegisterServerEvent("pepe-skills:addStamina")
AddEventHandler("pepe-skills:addStamina", function(source, amount)
	local Player = Framework.Functions.GetPlayer(source)
	--Framework.Functions.Notify("Je voelt je" .. round(amount, 2) .. "% sneller!", "error")
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		local addStamina = skillInfo[1].stamina + amount
		if addStamina > 95 then
			addStamina = 95
		end
		Framework.Functions.UpdateSql(true, "UPDATE `pepe-skills` SET `stamina` = @stamina WHERE `identifier` = @identifier",
			{
			['@stamina'] = addStamina,
			['@identifier'] = Player.PlayerData.citizenid
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("pepe-skills:addStrength")
AddEventHandler("pepe-skills:addStrength", function(source, amount)
	local Player = Framework.Functions.GetPlayer(source)
	--TriggerClientEvent('esx:showNotification', source, 'You feel ~g~' .. round(amount, 2) .. '% ~s~stronger!')
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		local addStrength = skillInfo[1].strength + amount
		if addStrength > 100 then
			addStrength = 100
		end
		Framework.Functions.UpdateSql(true, "UPDATE `pepe-skills` SET `strength` = @strength WHERE `identifier` = @identifier",
			{
			['@strength'] = addStrength,
			['@identifier'] = Player.PlayerData.citizenid
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("pepe-skills:addDriving")
AddEventHandler("pepe-skills:addDriving", function(source, amount)
	local Player = Framework.Functions.GetPlayer(source)
	--TriggerClientEvent('esx:showNotification', source, 'You became ~g~' .. round(amount, 2) .. '% ~s~better at driving!')
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		local addDriving = skillInfo[1].driving + amount
		if addDriving > 100 then
			addDriving = 100
		end
		Framework.Functions.UpdateSql(true, "UPDATE `pepe-skills` SET `driving` = @driving WHERE `identifier` = @identifier",
			{
			['@driving'] = addDriving,
			['@identifier'] = Player.PlayerData.citizenid
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("pepe-skills:addFishing")
AddEventHandler("pepe-skills:addFishing", function(source, amount)
	local Player = Framework.Functions.GetPlayer(source)
	--TriggerClientEvent('esx:showNotification', source, 'You became ~g~' .. round(amount, 2) .. '% ~s~better at fishing!')
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		local addFishing = skillInfo[1].fishing + amount
		if addFishing > 100 then
			addFishing = 100
		end
		Framework.Functions.UpdateSql(true, "UPDATE `pepe-skills` SET `fishing` = @fishing WHERE `identifier` = @identifier",
			{
			['@fishing'] = addFishing,
			['@identifier'] = Player.PlayerData.citizenid
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("pepe-skills:addDrugs")
AddEventHandler("pepe-skills:addDrugs", function(source, amount)
	local Player = Framework.Functions.GetPlayer(source)
	--TriggerClientEvent('esx:showNotification', source, 'You became ~g~' .. round(amount, 2) .. '% ~s~better at handling ~y~drugs~s~!')
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		local addDrugs = skillInfo[1].drugs + amount
		if addDrugs > 100 then
			addDrugs = 100
		end
		Framework.Functions.UpdateSql(true, "UPDATE `pepe-skills` SET `drugs` = @drugs WHERE `identifier` = @identifier",
			{
			['@drugs'] = addDrugs,
			['@identifier'] = Player.PlayerData.citizenid
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

Framework.Functions.CreateCallback('pepe-skills:getSkills', function(source, cb)
	local Player = Framework.Functions.GetPlayer(source)
	exports['ghmattimysql']:execute('SELECT * FROM `pepe-skills` WHERE `identifier` = @identifier', {['@identifier'] = Player.PlayerData.citizenid}, function(skillInfo)
		cb(skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
	end)
end)