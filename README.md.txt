## Events ##

1. Add "TriggerServerEvent('pepe-skills:addStamina', GetPlayerServerId(PlayerId()), (math.random() + 0))" 	to esx_gym where you want people to gain Stamina.
2. Add "TriggerServerEvent('pepe-skills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))" 	to esx_gym where you want people to gain Strength.
3. Add "TriggerServerEvent('pepe-skills:addFishing', GetPlayerServerId(PlayerId()), (math.random() + 0))" 	to your favorite fishing-mod. (I had my own fishing system so some tweaking might be required)
4. Add "TriggerServerEvent('pepe-skills:addDrugs', GetPlayerServerId(PlayerId()), (math.random() + 0))" 	to esx_drugs where you want people to gain drug-skill.

# Insert into /resources/[Cores]/pepe-core/server/player.lua #
# You only need to place the code between -- skills --
# +/- Line: 400 & 450

----------------------------------------------------------------------------------------------------------------------------------------
Framework.Player.Save = function(source)
	local PlayerData = Framework.Players[source].PlayerData
	if PlayerData ~= nil then
		Framework.Functions.ExecuteSql(true, "SELECT * FROM `characters_metadata` WHERE `citizenid` = @cid", {
			['@cid'] = PlayerData.citizenid,
		}, function(result)
			if result[1] == nil then
				-- Framework.Functions.ExecuteSqlOld(true, "INSERT INTO `characters_metadata` (`citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `position`, `job`, `gang`, `globals`) VALUES ('"..PlayerData.citizenid.."', '"..tonumber(PlayerData.cid).."', '"..PlayerData.steam.."', '"..PlayerData.license.."', '"..PlayerData.name.."', '"..json.encode(PlayerData.money).."', '"..Framework.EscapeSqli(json.encode(PlayerData.charinfo)).."', '"..json.encode(PlayerData.position).."', '"..json.encode(PlayerData.job).."', '"..json.encode(PlayerData.gang).."' ,'"..json.encode(PlayerData.metadata).."')")
				Framework.Functions.InsertSql(true, "INSERT INTO `characters_metadata` (`citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `position`, `job`, `gang`, `skills`, `globals`) VALUES (@citizenid, @cid, @steam, @license, @name, @money, @charinfo, @position, @job, @gang, @skills, @globals)", {
					['@citizenid'] = PlayerData.citizenid,
					['@cid'] = tonumber(PlayerData.cid),
					['@steam'] = PlayerData.steam,
					['@license'] = PlayerData.license,
					['@name'] = PlayerData.name,
					['@money'] = json.encode(PlayerData.money),
					['@charinfo'] = json.encode(PlayerData.charinfo),
					['@position'] = json.encode(PlayerData.position),
					['@job'] = json.encode(PlayerData.job),
					['@gang'] = json.encode(PlayerData.gang),
					['@skills'] = json.encode(PlayerData.skills),
					['@globals'] = json.encode(PlayerData.metadata),
				})
			else
				-- Framework.Functions.ExecuteSqlOld(true, "UPDATE `characters_metadata` SET steam='"..PlayerData.steam.."', name='"..Framework.EscapeSqli(PlayerData.name).."', money='"..Framework.EscapeSqli(json.encode(PlayerData.money)).."',charinfo='"..Framework.EscapeSqli(json.encode(PlayerData.charinfo)).."',position='"..Framework.EscapeSqli(json.encode(PlayerData.position)).."',job='"..Framework.EscapeSqli(json.encode(PlayerData.job)).."' ,globals='"..Framework.EscapeSqli(json.encode(PlayerData.metadata)).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
				Framework.Functions.UpdateSql(true, "UPDATE `characters_metadata` SET steam = @steam, name = @name, money = @money, charinfo = @charinfo, position = @position, job = @job, skills = @skills, globals = @globals WHERE `citizenid` = @cid", {
					['@steam'] = PlayerData.steam,
					['@name'] = PlayerData.name,
					['@money'] = json.encode(PlayerData.money),
					['@charinfo'] = json.encode(PlayerData.charinfo),
					['@position'] = json.encode(PlayerData.position),
					['@job'] = json.encode(PlayerData.job),
					['@gang'] = json.encode(PlayerData.gang),
					['@skills'] = json.encode(PlayerData.skills),
					['@globals'] = json.encode(PlayerData.metadata),
					['@cid'] = PlayerData.citizenid,
				})
			end
-- Skills --
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
-- Skills --

Framework.Player.SaveInventory(source)
		end)
		Framework.ShowSuccess(GetCurrentResourceName(), PlayerData.name .." PLAYER SAVED!")
	else
		print('SAVE DATA ERROR - NILL')
	end
end

-------------------------------------------------------------------------------------------------------------------------------------------------------