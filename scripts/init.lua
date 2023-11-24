local description = "Adds my wife's favorite Pokemon to the game as a squad. They evolve!"
local mod = {
	id = "Meta_Pokemon",
	name = "Pokemon Team",
	version = "1.0",
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
	require(self.scriptPath .."libs/saveData")
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
	modApi:addSquad(
		{"Pokemon Team","Poke_Abra", "Poke_Dratini", "Poke_Mew", id = "Poke_Squad"}, 
		"Pokemon Team", "A team of Pokemon.", 
		self.resourcePath .. "img/mod_icon.png")
		
	modApi:addMissionEndHook(function()		--revive dead pawns, do evolution stuff
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			local pilotLevel = GameData.current["pilot"..id].level
			if pawn:IsDead() then												--don't evolve if you were dead
				Board:DamageSpace(SpaceDamage(pawn:GetSpace(), -1))
            elseif pilotLevel > 0 and											--check whether we should consider evolving
			   _G[pawn:GetType()].HasEvolutions and 							--check it's a Pokemon that should evolve
			   _G[pawn:GetType()].HasEvolutions[pilotLevel] and 				--check whether it evolves at this level, it's {true, true} for Abra/Dratini
			   GAME.Poke_Evolutions[id+1] < pilotLevel then						--hasn't evolved already
			    LOG("evolving "..pawn:GetType())
                Game:TriggerSound("/ui/map/flyin_rewards")
				Board:AddAlert(pawn:GetSpace(), _G[pawn:GetType()].EvoNames[pilotLevel].." is evolving into ".._G[pawn:GetType()].EvoNames[pilotLevel+1].."!")
				pawn:SetCustomAnim("evolutionAnim")								--not working, very annoyed
				local delayDamage = SpaceDamage(Point(0, 0))					--also not working
				delayDamage.fDelay = 2
				Board:DamageSpace(delayDamage)
				for i = 1, pawn:GetWeaponCount() do								--remove weapon
					if pawn:GetWeaponBaseType(i) and pawn:GetWeaponBaseType(i) == _G[pawn:GetType()].EvoForget[pilotLevel] then LOG("removed") pawn:RemoveWeapon(i) break end
				end																
				for i = 1, #_G[pawn:GetType()].EvoLearn[pilotLevel] do			--add all weapons learnt on evolution
					pawn:AddWeapon(_G[pawn:GetType()].EvoLearn[pilotLevel][i])
				end
				GAME.Poke_Evolutions[id+1] = pilotLevel			
				--remember it evolved so we don't do it again
				Game:TriggerSound("/ui/map/flyin_rewards")
				Board:Ping(pawn:GetSpace(), GL_Color(255, 255, 255))
				pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[pilotLevel])	--update graphics
            end
        end
    end)
	modApi:addMissionStartHook(function()	--need to reassign graphics at mission start since the game forgets otherwise
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
        for id = 0, 2 do
            local pawn = Game:GetPawn(id)
			local evo = GAME.Poke_Evolutions[id + 1]
			if _G[pawn:GetType()].HasEvolutions and evo > 0 then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
			if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
			if _G[pawn:GetType()].HealthAtLevel and evo > 0 then pawn:SetMaxHealth(_G[pawn:GetType()].HealthAtLevel[evo]) pawn:SetHealth(_G[pawn:GetType()].HealthAtLevel[evo]) end
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
				if _G[pawn:GetType()].HasEvolutions and evo > 0 then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
			end
		end)
    end)
	modApi:addMissionNextPhaseCreatedHook(function()
		if GAME.Poke_Evolutions == nil then GAME.Poke_Evolutions = {0, 0, 0} end
		LOG("in hook")
		--We are not immediately in a mission after falling into the Volcanic Cave, so I add a temporary hook that'll only trigger once we are
		modApi:conditionalHook(function()
			return true and Game ~= nil and GAME ~= nil and GetCurrentMission() ~= nil and GetCurrentMission() ~= Mission_Test 
		end, 
		function()
			LOG("started phase")
			for id = 0, 2 do
				local pawn = Game:GetPawn(id)
				local evo = GAME.Poke_Evolutions[id + 1]
				if _G[pawn:GetType()].HasEvolutions and evo > 0 then pawn:SetCustomAnim(_G[pawn:GetType()].EvoGraphics[evo]) end
				if _G[pawn:GetType()].BecomeFlyingAtLevel and _G[pawn:GetType()].BecomeFlyingAtLevel <= evo then pawn:SetFlying(true) end
				if _G[pawn:GetType()].KeepAdding and _G[pawn:GetType()].KeepAdding[evo] and _G[pawn:GetType()].KeepAdding[evo] ~= "" and pawn:GetWeaponCount() < 3 then 
					pawn:AddWeapon(_G[pawn:GetType()].KeepAdding[evo]) 
				end
			end
		end)
    end)
end

return mod
