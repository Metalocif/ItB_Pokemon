local description = "Adds several Pokemon squads to the game. Gotta catch 'em all!"
local mod = {
	id = "Meta_Pokemon",
	name = "Pokemon Team",
	version = "1.2",
	requirements = {},
	dependencies = { 
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	modApiVersion = "2.9.1",
	icon = "img/mod_icon.png",
	description = description,
}

function mod:init()
	require(self.scriptPath .."weapons")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."bosses")
	require(self.scriptPath .."libs/saveData")
	
	require(self.scriptPath .."missions/mission_mewtwo")
	require(self.scriptPath .."missions/mission_mewtwo_dialog")
	require(self.scriptPath .."missions/mission_deoxys")
	require(self.scriptPath .."missions/mission_deoxys_dialog")
	require(self.scriptPath .."missions/mission_darkrai")
	require(self.scriptPath .."missions/mission_darkrai_dialog")
	modApi:appendAssets("img/strategy/mission/", "img/strategy/mission/", "")
	modApi:appendAssets("img/strategy/mission/small/", "img/strategy/mission/small/", "")
	self.modApiExt = require(self.scriptPath .."modApiExt/modApiExt")
	self.modApiExt:init()
	self.missions = require(self.scriptPath .."missions/init")
	self.missions:init(self)	
	-- local corpMissions = require(self.scriptPath .."corpMissions")
	-- corpMissions.Add_Missions_High("Mission_Poke_Mewtwo", "Corp_Grass")
	-- corpMissions.Add_Missions_High("Mission_Poke_Deoxys", "Corp_Acid")
	-- corpMissions.Add_Missions_High("Mission_Poke_Darkrai", "Corp_Grass")
	local ml = easyEdit.missionList:get("archive")
	ml.addMission(ml._default , "Mission_Poke_Mewtwo", true)
	ml.addMission(ml._default , "Mission_Poke_Darkrai", true)
	local ml = easyEdit.missionList:get("detritus")
	ml.addMission(ml._default , "Mission_Poke_Deoxys", true)
	-- local ml = easyEdit.missionList:get("Meridia")
	-- ml:addMission("Mission_Poke_Celebi", true)
	-- ml:addMission("Mission_Poke_Shaymin", true)
	-- ml:addMission("Mission_Poke_Xerneas", true)
	modApi:addModsInitializedHook(function()
		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
			local result = oldGetStartingSquad(choice, ...)

			if choice == 0 then
				local copy = {}
				for i, v in pairs(result) do
					copy[#copy+1] = v
				end
				table.insert(copy, "Poke_ArmoredMewtwo")

				return copy
			end

			return result
		end
	end)
end

local function isMission()
	local mission = GetCurrentMission()

	return true
		and Game ~= nil
		and GAME ~= nil
		and mission ~= nil
		and mission ~= Mission_Test
end

function mod:load( options, version)
	self.modApiExt:load(self, options, version)
	self.missions:load(self, options, version)
	
	modApi:addSquad(
		{"Pokemon Team","Poke_Abra", "Poke_Dratini", "Poke_Mew", id = "Poke_Squad"}, 
		"Pokemon Team", "A team of Pokemon.", 
		self.resourcePath .. "img/mod_icon.png")
	if modApi.achievements:isComplete(mod.id,"Poke_ArticunoCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_ZapdosCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_MoltresCapture") then 

		modApi:addSquad(
		{"Legendary Birds","Poke_Articuno", "Poke_Zapdos", "Poke_Moltres", id = "Poke_BirdSquad"}, 
		"Legendary Birds", "The three legendary birds of Kanto.", 
		self.resourcePath .. "img/birds_icon.png")
	end
	if modApi.achievements:isComplete(mod.id,"Poke_MewtwoCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_DeoxysCapture") and 
	   modApi.achievements:isComplete(mod.id,"Poke_DarkraiCapture") then 

		modApi:addSquad(
		{"Dark Minds","Poke_Mewtwo", "Poke_Deoxys", "Poke_Darkrai", id = "Poke_EvilSquad"}, 
		"Dark Minds", "These ruthless Pokemon will crush the Vek.", 
		self.resourcePath .. "img/evil_icon.png")
	end
	-- table.insert(modApi.mod_squads[#modApi.mod_squads], "Poke_ArmoredMewtwo")
	-- if modApi.achievements:isComplete(mod.id,"Poke_MewtwoCapture") and 
	   -- modApi.achievements:isComplete(mod.id,"Poke_DeoxysCapture") and 
	   -- modApi.achievements:isComplete(mod.id,"Poke_DarkraiCapture") then 

		modApi:addSquad(
		{"Nature's Guardians","Poke_Celebi", "Poke_Shaymin", "Poke_Xerneas", id = "Poke_NatureSquad"}, 
		"Nature's Guardians", "Protectors of nature, these Pokemon will heal the planet.", 
		self.resourcePath .. "img/nature_icon.png")
	-- end
		
	modApi:addMissionEndHook(function()		--revive dead pawns, do evolution stuff
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			local pilotLevel = GameData.current["pilot"..id].level
			if pawn:IsDead() then												--don't evolve if you were dead
				Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -1))
            elseif pilotLevel > 0 then											--check whether we should consider evolving
				if _G[pawn:GetType()].HasEvolutions and 							--check it's a Pokemon that should evolve
			       _G[pawn:GetType()].HasEvolutions[pilotLevel] and 				--check whether it evolves at this level, it's {true, true} for Abra/Dratini
			       GAME.Poke_Evolutions[id+1] < pilotLevel then						--hasn't evolved already
					LOG("evolving "..pawn:GetType())
					Game:TriggerSound("/ui/map/flyin_rewards")
					if _G[pawn:GetType()].EvoNames then
						Board:AddAlert(pawn:GetSpace(), _G[pawn:GetType()].EvoNames[pilotLevel].." is evolving into ".._G[pawn:GetType()].EvoNames[pilotLevel+1].."!")
						pawn:SetCustomAnim("evolutionAnim")								--not working, very annoyed
						local delayDamage = SpaceDamage(Point(0, 0))					--also not working
						delayDamage.fDelay = 2
						Board:DamageSpace(delayDamage)
					end
					
					for i = 1, pawn:GetWeaponCount() do								--remove weapon
						if pawn:GetWeaponBaseType(i) and pawn:GetWeaponBaseType(i) == _G[pawn:GetType()].EvoForget[pilotLevel] then LOG("removed") pawn:RemoveWeapon(i) break end
					end																
					for i = 1, #_G[pawn:GetType()].EvoLearn[pilotLevel] do			--add all weapons learnt on evolution
						pawn:AddWeapon(_G[pawn:GetType()].EvoLearn[pilotLevel][i])
					end		
					
					Game:TriggerSound("/ui/map/flyin_rewards")
					Board:Ping(pawn:GetSpace(), GL_Color(255, 255, 255))
					if _G[pawn:GetType()].EvoGraphics and _G[pawn:GetType()].EvoGraphics[pilotLevel] ~= "" then --update graphics
						pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[pilotLevel])
					end 
				end
				GAME.Poke_Evolutions[id+1] = pilotLevel			--set this separately from evolution so that evoless Pokemon can get stuff with levels anyway
				--remember it evolved so we don't do it again
            end
        end
    end)
	modApi:addMissionStartHook(function()	--need to reassign graphics at mission start since the game forgets otherwise
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			local evo = GAME.Poke_Evolutions[id + 1]
			if _G[pawn:GetType()].HasEvolutions and evo > 0 and _G[pawn:GetType()].EvoGraphics then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
			if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
			if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
			if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
				pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
			end
        end
    end)
	modApi:addPostLoadGameHook(function()
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		--We are not immediately in a mission after resetting turn, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			for id = 0, 2 do
				local pawn = Game:GetPawn(id)
				local evo = GAME.Poke_Evolutions[id + 1]
				if _G[pawn:GetType()].HasEvolutions and evo > 0 and _G[pawn:GetType()].EvoGraphics then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
			end
		end)
    end)
	modApi:addMissionNextPhaseCreatedHook(function()
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		--We are not immediately in a mission after falling into the Volcanic Cave, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			for id = 0, 2 do
				local pawn = Game:GetPawn(id)
				local evo = GAME.Poke_Evolutions[id + 1]
				if _G[pawn:GetType()].HasEvolutions and evo > 0 and _G[pawn:GetType()].EvoGraphics then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(pawn:GetHealth() + _G[pawn:GetType()].HealthAtLevel[evo]) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
			end
		end)
    end)
	modApi:addNextTurnHook(function()		--handles Hyper Beam and potentially other moves with a recovery turn
		-- for id = 0, 2 do
			-- local pawn = Game:GetPawn(id)
			-- if not pawn:IsPowered() and pawn:GetCustomAnim():sub(-6, -1) == "_sleep" then
				-- pawn:SetPowered(true)
				-- pawn:SetActive(false)
			-- elseif pawn:GetCustomAnim():sub(-6, -1) == "_sleep" then
				-- pawn:SetCustomAnim(_G[pawn:GetType()].Image)
				-- pawn:SetActive(true)
			-- end
		-- end
		if GetCurrentMission().SleepTable == nil then LOG("no table") GetCurrentMission().SleepTable = {} else LOG("ok") end
		for id, sleepTurnsLeft in pairs(GetCurrentMission().SleepTable) do
			LOG(id, sleepTurnsLeft)
			local pawn = Board:GetPawn(id)
			LOG(pawn:GetType())
			if pawn and sleepTurnsLeft >= 0 then GetCurrentMission().SleepTable[id] = GetCurrentMission().SleepTable[id] - 1 end	
			--go down to -1 so we don't setpowered things that shouldn't be
			if sleepTurnsLeft == 1 then 
				pawn:SetPowered(true)
				if pawn:GetCustomAnim():sub(-6, -1) == "_sleep" then						--some pawns will use a customanim for sleep but most won't
					pawn:SetCustomAnim(_G[pawn:GetType()].Image)
				else
					CustomAnim:rem(id, "sleepAnim")
				end
			end
		end
	end)
end

local function init(self)
	meta_missions_modApiExt = require(self.scriptPath.."modApiExt/modApiExt"):init()
end

return mod
