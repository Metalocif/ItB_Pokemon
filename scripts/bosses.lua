easyEdit.bossList:get("pinnacle"):addBoss("Mission_ArticunoBoss")
easyEdit.bossList:get("rst"):addBoss("Mission_ZapdosBoss")
easyEdit.bossList:get("archive"):addBoss("Mission_MoltresBoss")
-- easyEdit.bossList:get("finale2"):addBoss("Mission_MewtwoBoss")
-- easyEdit.bossList:get("finale1"):addBoss("Mission_DarkraiBoss")
-- easyEdit.bossList:get("detritus"):addBoss("Mission_DeoxysBoss")

local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath

achievements = {
	Poke_ZapdosCapture = modApi.achievements:add{
		id = "Poke_ZapdosCapture",
		name = "Captured Zapdos",
		tip = "Capture the legendary bird Zapdos, who flies above the thunderstorms.",
		img = resourcePath.."img/units/aliens/Zapdos.png",
		global = "Pokemon",
	},

	Poke_ArticunoCapture = modApi.achievements:add{
		id = "Poke_ArticunoCapture",
		name = "Captured Articuno",
		tip = "Capture the legendary bird Articuno, who glides above the snowstorms.",
		img = resourcePath.."img/units/aliens/Articuno.png",
		global = "Pokemon",
	},

	Poke_MoltresCapture = modApi.achievements:add{
		id = "Poke_MoltresCapture",
		name = "Captured Moltres",
		tip = "Capture the legendary bird Moltres, who soars above the forests.",
		img = resourcePath.."img/units/aliens/Moltres.png",
		global = "Pokemon",
	},
	
	Poke_MewtwoCapture = modApi.achievements:add{
		id = "Poke_MewtwoCapture",
		name = "Captured Mewtwo",
		tip = "Capture the genetic creation Mewtwo, who dwells in a dangerous cave.",
		img = resourcePath.."img/units/aliens/Mewtwo.png",
		global = "Pokemon",
	},
	Poke_DeoxysCapture = modApi.achievements:add{
		id = "Poke_DeoxysCapture",
		name = "Captured Deoxys",
		tip = "Capture the alien Deoxys, who stays in a moon-like biome.",
		img = resourcePath.."img/units/aliens/Deoxys.png",
		global = "Pokemon",
	},
	Poke_DarkraiCapture = modApi.achievements:add{
		id = "Poke_DarkraiCapture",
		name = "Captured Darkrai",
		tip = "Capture the pitch-black Darkrai, who hides in nightmares.",
		img = resourcePath.."img/units/aliens/Darkrai.png",
		global = "Pokemon",
	},
}


local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath
local writepath = "img/units/aliens/"
local readpath = path .. writepath
local imagepath = writepath:sub(5,-1)

modApi:appendAsset(writepath .."Articuno.png", readpath .."Articuno.png")
modApi:appendAsset(writepath .."Articuno_a.png", readpath .."Articuno_a.png")
modApi:appendAsset(writepath .."Articuno_d.png", readpath .."Articuno_d.png")

modApi:appendAsset(writepath .."Zapdos.png", readpath .."Zapdos.png")
modApi:appendAsset(writepath .."Zapdos_a.png", readpath .."Zapdos_a.png")
modApi:appendAsset(writepath .."Zapdos_d.png", readpath .."Zapdos_d.png")

modApi:appendAsset(writepath .."Moltres.png", readpath .."Moltres.png")
modApi:appendAsset(writepath .."Moltres_a.png", readpath .."Moltres_a.png")
modApi:appendAsset(writepath .."Moltres_d.png", readpath .."Moltres_d.png")

modApi:appendAsset(writepath .."Mewtwo.png", readpath .."Mewtwo.png")
modApi:appendAsset(writepath .."Mewtwo_a.png", readpath .."Mewtwo_a.png")
modApi:appendAsset(writepath .."Mewtwo_d.png", readpath .."Mewtwo_d.png")

modApi:appendAsset(writepath .."Deoxys.png", readpath .."Deoxys.png")
modApi:appendAsset(writepath .."Deoxys_a.png", readpath .."Deoxys_a.png")
modApi:appendAsset(writepath .."Deoxys_d.png", readpath .."Deoxys_d.png")
modApi:appendAsset(writepath .."DeoxysA.png", readpath .."DeoxysA.png")
modApi:appendAsset(writepath .."DeoxysA_a.png", readpath .."DeoxysA_a.png")
modApi:appendAsset(writepath .."DeoxysA_d.png", readpath .."DeoxysA_d.png")
modApi:appendAsset(writepath .."DeoxysD.png", readpath .."DeoxysD.png")
modApi:appendAsset(writepath .."DeoxysD_a.png", readpath .."DeoxysD_a.png")
modApi:appendAsset(writepath .."DeoxysD_d.png", readpath .."DeoxysD_d.png")
modApi:appendAsset(writepath .."DeoxysS.png", readpath .."DeoxysS.png")
modApi:appendAsset(writepath .."DeoxysS_a.png", readpath .."DeoxysS_a.png")
modApi:appendAsset(writepath .."DeoxysS_d.png", readpath .."DeoxysS_d.png")

modApi:appendAsset(writepath .."Darkrai.png", readpath .."Darkrai.png")
modApi:appendAsset(writepath .."Darkrai_a.png", readpath .."Darkrai_a.png")
modApi:appendAsset(writepath .."Darkrai_d.png", readpath .."Darkrai_d.png")

modApi:appendAsset(writepath .."MasterBall.png", readpath .."MasterBall.png")

local a = ANIMS
local base = a.EnemyUnit:new{Image = imagepath .."Articuno.png", PosX = -50, PosY = -31, NumFrames = 1, Height = 1 }
a.Articuno_B  =	base
a.Articuno_Ba =	base:new{ Image = "units/aliens/Articuno_a.png", NumFrames = 6 }
a.Articuno_Bd =	base:new{ Image = "units/aliens/Articuno_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."Zapdos.png", PosX = -35, PosY = -31, NumFrames = 1, Height = 1 }
a.Zapdos_B  =	base
a.Zapdos_Ba =	base:new{ Image = "units/aliens/Zapdos_a.png", NumFrames = 6 }
a.Zapdos_Bd =	base:new{ Image = "units/aliens/Zapdos_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."Moltres.png", PosX = -50, PosY = -31, NumFrames = 1, Height = 1 }
a.Moltres_B  =	base
a.Moltres_Ba =	base:new{ Image = "units/aliens/Moltres_a.png", NumFrames = 6 }
a.Moltres_Bd =	base:new{ Image = "units/aliens/Moltres_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."Mewtwo.png", PosX = -25, PosY = -16, NumFrames = 1, Height = 1 }
a.Mewtwo_B  =	base
a.Mewtwo_Ba =	base:new{ Image = "units/aliens/Mewtwo_a.png", NumFrames = 6 }
a.Mewtwo_Bd =	base:new{ Image = "units/aliens/Mewtwo_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."Deoxys.png", PosX = -15, PosY = -11, NumFrames = 1, Height = 1 }
a.Deoxys_B  =	base
a.Deoxys_Ba =	base:new{ Image = "units/aliens/Deoxys_a.png", NumFrames = 8 }
a.Deoxys_Bd =	base:new{ Image = "units/aliens/Deoxys_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."DeoxysA.png", PosX = -15, PosY = -11, NumFrames = 1, Height = 1 }
a.Deoxys_BA  =	base
a.Deoxys_BAa =	base:new{ Image = "units/aliens/DeoxysA_a.png", NumFrames = 4 }
a.Deoxys_BAd =	base:new{ Image = "units/aliens/DeoxysA_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."DeoxysD.png", PosX = -15, PosY = -11, NumFrames = 1, Height = 1 }
a.Deoxys_BD  =	base
a.Deoxys_BDa =	base:new{ Image = "units/aliens/DeoxysD_a.png", NumFrames = 6 }
a.Deoxys_BDd =	base:new{ Image = "units/aliens/DeoxysD_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."DeoxysS.png", PosX = -15, PosY = -11, NumFrames = 1, Height = 1 }
a.Deoxys_BS  =	base
a.Deoxys_BSa =	base:new{ Image = "units/aliens/DeoxysS_a.png", NumFrames = 6 }
a.Deoxys_BSd =	base:new{ Image = "units/aliens/DeoxysS_d.png", PosX = -30, NumFrames = 6, Time = 0.2, Loop = false }

local base = a.EnemyUnit:new{Image = imagepath .."Darkrai.png", PosX = -15, PosY = -11, NumFrames = 1, Height = 1 }
a.Darkrai_B  =	base
a.Darkrai_Ba =	base:new{ Image = "units/aliens/Darkrai_a.png", PosX = -25, NumFrames = 8 }
a.Darkrai_Bd =	base:new{ Image = "units/aliens/Darkrai_d.png", NumFrames = 8, Time = 0.2, Loop = false }

a.MasterBall = a.EnemyUnit:new{Image = imagepath .."MasterBall.png", PosX = -8, PosY = 0, NumFrames = 1, Height = 1 }

---- MISSION DESCRIPTION
Mission_ArticunoBoss = Mission_Boss:new{
	Name = "Articuno",
	BossPawn = "Poke_ArticunoBoss",
	GlobalSpawnMod = -1,	
	BossText = "Capture Articuno",
	Environment = "Env_SnowStormArticuno",
	BallID = -1,
}

Env_SnowStormArticuno = Env_SnowStorm		--only difference is it heals Articuno

function Env_SnowStormArticuno:ApplyEffect()
	
	local effect = SkillEffect()
	local damage = SpaceDamage(Point(0,0), 0)
	damage.sAnimation = ""
	damage.iFrozen = 1
	
	local loc = self.LastLoc + Point(-1,-1)
	local weather = RAIN_SNOW
	local script = "Board:SetWeather(5,"..weather..","..loc:GetString()..",Point(3,3),2)"
	effect:AddScript(script)
	effect:AddSound("/props/snow_storm")
	effect:AddDelay(1)
	for i,v in ipairs(self.Locations) do
		if Board:GetPawn(v) and Board:GetPawn(v):GetId() == GetCurrentMission().BossID then
			effect:AddDamage(SpaceDamage(v, -1))
		else
			damage.loc = v
			effect:AddDamage(damage)
		end
	end
	effect.iOwner = ENV_EFFECT
	Board:AddEffect(effect)
	self.CurrentAttack = self.Locations
	self.Locations = {}
	
	return false
end

function Mission_ArticunoBoss:IsBossDead()
	return (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID)
end

function Mission_ArticunoBoss:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_ArticunoCapture:isComplete() then achievements.Poke_ArticunoCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then
	    objectives = { objectives } 
	end
	
	local total_rep = 0
	local total_possible = 0
	for i,v in ipairs(objectives) do
		total_rep = v.rep + total_rep
		total_possible = v.potential + total_possible
	end
	
	if total_rep == total_possible then
		return "Success"
	elseif total_rep == 0 then
		return "Failure"
	else
		return "Partial"
	end
end

-------- BOSS DESCRIPTION
Poke_ArticunoBoss = {
	Health = 7,
	MoveSpeed = 4,
	Image = "Articuno_B",
	Name = "Articuno",
	-- ImageOffset = 2,
	SkillList = { "Poke_IcyWindBoss" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
}
AddPawn("Poke_ArticunoBoss") 

function Poke_ArticunoBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

Poke_MasterBall = Pawn:new{
	Name = "Master Ball",
	Health = 1,
	Neutral = true,
	MoveSpeed = 0,
	Minor = true,
	IsPortrait = false,
	Image = "MasterBall",
	SoundLocation = "/support/disposal",
	SkillList = {},
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
}
AddPawn("Poke_MasterBall") 

Poke_IcyWindBoss = Skill:new{
	Name = "Icy Wind",
	Class = "Enemy",
	PathSize = 1,
	Damage = 2,
	Description = "Deals damage and chills. Pierces through up to one target. Will freeze an already chilled target.",
	ProjectileArt = "effects/icywind",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building = Point(2,0),
		Target = Point(2,2),
		CustomPawn = "Poke_ArticunoBoss"
	}
}

function Poke_IcyWindBoss:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point + DIR_VECTORS[i])
	end
	return ret
end


function Poke_IcyWindBoss:GetSkillEffect(p1,p2)		--do chill
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local first_tar = GetProjectileEnd(p1,p2,PATH_PROJECTILE)  
	local second_tar = GetProjectileEnd(first_tar,first_tar+DIR_VECTORS[dir],PATH_PROJECTILE)  
		
	if Board:IsValid(second_tar) and second_tar ~= first_tar then
		
		local damage = SpaceDamage(second_tar, self.Damage)
		
		ret:AddQueuedProjectile(damage, self.ProjectileArt, NO_DELAY)
		
		local distance = first_tar:Manhattan(p1)
		ret:AddQueuedDelay(distance*0.1 + 0.2)
		local first_damage = SpaceDamage(first_tar, self.Damage)
		ret:AddQueuedDamage(first_damage)
		
	else
	
		local damage = SpaceDamage(first_tar, self.Damage)
		ret:AddQueuedProjectile(damage, self.ProjectileArt)
		
	end
	return ret
end

----------
--ZAPDOS--
----------

---- MISSION DESCRIPTION
Mission_ZapdosBoss = Mission_Boss:new{
	Name = "Zapdos",
	BossPawn = "Poke_ZapdosBoss",
	GlobalSpawnMod = -1,	
	BossText = "Capture Zapdos",
	Environment = "Env_LightningZapdos",
	BallID = -1,
}

Env_LightningZapdos = Env_Lightning		--only difference is it boosts Zapdos

function Env_LightningZapdos:GetAttackEffect(location)
	local effect = SkillEffect()
	local damage = SpaceDamage(location, DAMAGE_DEATH)
	damage.sAnimation = "LightningBolt"..random_int(2)
	local rain = location - Point(1,1)
	local script = "Board:SetWeather(3,"..RAIN_NORMAL..","..rain:GetString()..",Point(2,2),2)"
	effect:AddScript(script)
	effect:AddSound("/props/lightning_strike")
	effect:AddDelay(1)
	if Board:GetPawn(location) and Board:GetPawn(location):GetId() == GetCurrentMission().BossID then
		damage.iDamage = DAMAGE_ZERO
		damage.sScript = string.format("Board:GetPawn(%s):SetBoosted(true)", location:GetString())
	end
	effect:AddDamage(damage)
	return effect
end

function Env_LightningZapdos:SelectSpaces()
	local ret = {}
	local quarters = self:GetQuarters()
	for i,v in ipairs(quarters) do
		local tile
		repeat 
			tile = random_element(v)
		until not Board:GetPawn(GetCurrentMission().BallID) or tile ~= Board:GetPawn(GetCurrentMission().BallID):GetSpace()
		ret[#ret+1] = random_element(v)
	end
	return ret
end

function Mission_ZapdosBoss:IsBossDead()
	return (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID)
end

function Mission_ZapdosBoss:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_ZapdosCapture:isComplete() then achievements.Poke_ZapdosCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then
	    objectives = { objectives } 
	end
	
	local total_rep = 0
	local total_possible = 0
	for i,v in ipairs(objectives) do
		total_rep = v.rep + total_rep
		total_possible = v.potential + total_possible
	end
	
	if total_rep == total_possible then
		return "Success"
	elseif total_rep == 0 then
		return "Failure"
	else
		return "Partial"
	end
end


-------- BOSS DESCRIPTION
Poke_ZapdosBoss = {
	Health = 7,
	MoveSpeed = 4,
	Image = "Zapdos_B",
	Name = "Zapdos",
	-- ImageOffset = 2,
	SkillList = { "Poke_ShockwaveBoss" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
}
AddPawn("Poke_ZapdosBoss") 

function Poke_ZapdosBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

Poke_ShockwaveBoss = Skill:new{
	Name = "Shockwave",
	Class = "Enemy",
	PathSize = 1,
	Damage = 1,
	Description = "Sends a projectile in all four directions.",
	ProjectileArt = "effects/laser_elec",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,3),
		Building2 = Point(3,3),
		CustomPawn = "Poke_ZapdosBoss"
	}
}

function Poke_ShockwaveBoss:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end


function Poke_ShockwaveBoss:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	for i = DIR_START, DIR_END do
		local target = GetProjectileEnd(p1, p1 + DIR_VECTORS[i])
		local damage = SpaceDamage(target, self.Damage)
		damage.sAnimation = "LightningBolt0"
		ret:AddQueuedProjectile(damage, self.ProjectileArt, NO_DELAY)
	end
	return ret
end

-----------
--MOLTRES--
-----------

---- MISSION DESCRIPTION
Mission_MoltresBoss = Mission_Boss:new{
	Name = "Moltres",
	BossPawn = "Poke_MoltresBoss",
	GlobalSpawnMod = -1,	
	BossText = "Capture Moltres",
	Environment = "Env_VolcanoMoltres",
	-- CustomTile = "tiles_volcano",	--should make the fight use the volcano tileset, except it makes buildings pylons; may make my own tileset later
	BallID = -1,
}

Env_VolcanoMoltres = Env_Volcano		--only difference is it boosts Moltres


function Env_VolcanoMoltres:Start()
	Env_Attack.Start(self)
	self.LavaStart = self.LavaStart or {Point(2,1), Point(1,2)}
end

function Env_VolcanoMoltres:MarkSpace(space, active)
	local icon = self.RockIcon
	local tooltip = "flying_rock"
	local deadly = true
	
	local color = GL_Color(255,226,88,0.75)
	if Board:IsTerrain(space,TERRAIN_LAVA) then
		color = GL_Color(40,40,0)
	end
	Board:MarkSpaceImage(space,icon, color)
	Board:MarkSpaceDesc(space,tooltip, deadly)
	
	if active then
		Board:MarkSpaceImage(space,icon, GL_Color(255,150,150,0.75))
	end
end

function Env_VolcanoMoltres:SelectSpaces()
	self.Mode = ENV_ROCKS	--just in case
	local ret = {}
	
	local quarters = self:GetQuarters()
	for i,v in ipairs(quarters) do
		local choice = Point(1,1)
		while (choice == Point(1,1) or (GetCurrentMission().BallID and Board:GetPawn(GetCurrentMission().BallID) and choice == Board:GetPawn(GetCurrentMission().BallID):GetSpace())) and #v > 1 do
			choice = random_element(v)
		end
		
		if choice ~= Point(1,1) then
			ret[#ret+1] = choice 
		end
	end
	
	return ret
end

function Env_VolcanoMoltres:GetAttackEffect(location, effect)
	local effect = effect or SkillEffect()
	effect.piOrigin = Point(0, 0)
	--Board:GetPawn(GetCurrentMission().BossID):GetSpace() or 
	--change piOrigin to random mountain
	effect:AddSound("/weapons/fireball")
	local damage = SpaceDamage(location, DAMAGE_DEATH)
	if Board:GetPawn(location) and GetCurrentMission().BossID and Board:GetPawn(location):GetId() == GetCurrentMission().BossID then
		effect:AddArtillery(SpaceDamage(location), "effects/shotup_fireball.png", PROJ_DELAY)
		effect:AddScript(string.format("Board:GetPawn(%s):AddMoveBonus(2)", location:GetString()))
	else
		damage.iFire = 1
		damage.sAnimation = "explo_fire1"
		effect:AddArtillery(damage,"effects/shotup_fireball.png", PROJ_DELAY)
	end
	return effect
end


function Mission_MoltresBoss:IsBossDead()
	return (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID)
end

function Mission_MoltresBoss:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_MoltresCapture:isComplete() then achievements.Poke_MoltresCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then
	    objectives = { objectives } 
	end
	
	local total_rep = 0
	local total_possible = 0
	for i,v in ipairs(objectives) do
		total_rep = v.rep + total_rep
		total_possible = v.potential + total_possible
	end
	
	if total_rep == total_possible then
		return "Success"
	elseif total_rep == 0 then
		return "Failure"
	else
		return "Partial"
	end
end

-------- BOSS DESCRIPTION
Poke_MoltresBoss = {
	Health = 7,
	MoveSpeed = 4,
	Image = "Moltres_B",
	Name = "Moltres",
	-- ImageOffset = 2,
	SkillList = { "Poke_HeatWaveBoss" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
	IgnoreFire = true,
}
AddPawn("Poke_MoltresBoss") 

function Poke_MoltresBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

Poke_HeatWaveBoss = Skill:new{
	Name = "Heat Wave",
	Class = "Enemy",
	PathSize = 1,
	Damage = 2,
	Description = "Sends forth three projectiles that push and burn; they deal damage to burned targets.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,1),
		Building1 = Point(2,0),
		Target = Point(2,2),
		Building2 = Point(3,3),
		CustomPawn = "Poke_MoltresBoss"
	}
}

function Poke_HeatWaveBoss:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+ DIR_VECTORS[i])
	end
	return ret
end

SkillEffect["New_AddQueuedProjectile"] = function(self, origin, damage, graphics, delay) -- add our own queued projectile that can start from anywhere
	local fx = SkillEffect()
	fx["AddProjectile"](fx, origin, damage, graphics, delay)
	self.q_effect:AppendAll(fx.effect)
end

function Poke_HeatWaveBoss:GetSkillEffect(p1,p2)		
	local ret = SkillEffect()
	local dir = GetDirection(p2-p1)
	local offset = DIR_VECTORS[(dir+1)%4]
	for i = -1, 1 do
		local curr = p1 + offset * i
		local target = GetProjectileEnd(curr, p2 + offset * i)
		local damage = SpaceDamage(target, 0, dir)
		damage.iFire = 1
		if Board:IsFire(target) or (Board:GetPawn(target) and Board:GetPawn(target):IsFire()) then damage.iDamage = 2 end
		-- ret:AddQueuedProjectile(damage, "effects/heatwave", NO_DELAY)
		ret:New_AddQueuedProjectile(curr, damage, "effects/heatwave", NO_DELAY)
	end
	return ret
end


-- Mission_MewtwoBoss = Mission_Boss:new{	--just here so that Mewtwo can be rolled in the final mission's second phase
	-- Name = "Mewtwo",
	-- BossPawn = "Poke_MewtwoBoss",
	-- GlobalSpawnMod = -1,	
	-- BossText = "Capture Mewtwo",
-- }

Poke_MewtwoBoss = {
	Health = 7,
	MoveSpeed = 4,
	Image = "Mewtwo_B",
	Name = "Mewtwo",
	SkillList = { "Poke_PsychicBoss" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
	Flying = true,
	Teleporter = true,
	Massive = true,
}
AddPawn("Poke_MewtwoBoss") 

function Poke_MewtwoBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

Poke_PsychicBoss = Skill:new{
	Class = "Enemy",
	Icon = "weapons/Psychic.png",	
	Rarity = 3,
	Name = "Psystrike",
	Description = "Strikes three targets with psychic powers, pushing them.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_MewtwoBoss",
	}
}

function Poke_PsychicBoss:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr) 
		end
	end
	return ret
end

function Poke_PsychicBoss:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage, direction)
	damage.sAnimation = "confusionAnim"
	ret:AddQueuedDamage(damage)
	damage.loc = p2 + DIR_VECTORS[(direction + 1)%4]
	ret:AddQueuedDamage(damage)
	damage.loc = p2 + DIR_VECTORS[(direction + 3)%4]
	ret:AddQueuedDamage(damage)
	return ret
end


-- Mission_DeoxysBoss = Mission_Boss:new{
	-- Name = "Deoxys",
	-- BossPawn = "Poke_DeoxysBoss",
	-- GlobalSpawnMod = -1,	
	-- BossText = "Capture Deoxys",
	-- CustomTile = "tiles_debris",
	-- BallID = -1,
-- }

-- function Mission_DeoxysBoss:IsBossDead()
	-- return (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID)
-- end


-- function Mission_DeoxysBoss:GetCompletedStatus()
	-- local objectives = self:GetCompletedObjectives()
	
	-- if (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID) then
		-- if not achievements.Poke_DeoxysCapture:isComplete() then achievements.Poke_DeoxysCapture:addProgress{ complete = true } end
	-- end
	
	-- if type(objectives) ~= "table" then
	    -- objectives = { objectives } 
	-- end
	
	-- local total_rep = 0
	-- local total_possible = 0
	-- for i,v in ipairs(objectives) do
		-- total_rep = v.rep + total_rep
		-- total_possible = v.potential + total_possible
	-- end
	
	-- if total_rep == total_possible then
		-- return "Success"
	-- elseif total_rep == 0 then
		-- return "Failure"
	-- else
		-- return "Partial"
	-- end
-- end


Poke_DeoxysBoss = {
	Health = 6,		--gets a shield every turn
	MoveSpeed = 7,
	Image = "Deoxys_B",
	Name = "Deoxys",
	-- ImageOffset = 2,
	SkillList = { "Poke_FormChangeBoss", "Poke_AlienWhip" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
	Massive = true,
	GetWeapon = IAMSPEED,
}
AddPawn("Poke_DeoxysBoss") 


function Poke_DeoxysBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

function IAMSPEED()
	Pawn:SetCustomAnim("Deoxys_BS")
	return 1
end

Poke_FormChangeBoss = Skill:new{
	Class = "Enemy",
	Icon = "weapons/FormChange.png",	
	Rarity = 3,
	Name = "Form Change",
	Description = "Gain a shield before attacking, then strikes the front three tiles three times.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	Self = "Poke_FormChangeBoss",
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_DeoxysBoss",
	}
}

function Poke_FormChangeBoss:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		ret:push_back(curr) 
	end
	return ret
end

function Poke_FormChangeBoss:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Deoxys_BD"))
	ret:AddScript(string.format("Board:GetPawn(%s):SetShield(true)", p1:GetString()))
	local damage = SpaceDamage(p2, 1)
	damage.sSound = "/weapons/sword"
	damage.sAnimation = "alienwhip"..math.random(0, 3).."_"..direction
	ret:AddQueuedScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Deoxys_BA"))
	local script = string.format([[
		local fx = SkillEffect();
		fx:AddScript("Board:GetPawn(%s):FireWeapon(%s, 2)");
		Board:AddEffect(fx);
	]], p1:GetString(), p2:GetString())
	damage.sScript = script..script
	ret:AddQueuedMelee(p1, damage)
	ret:AddQueuedDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+1)%4], 1))
	ret:AddQueuedDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+3)%4], 1))
	return ret
end

Poke_AlienWhip = Skill:new{
	Class = "Enemy",
	Icon = "weapons/FormChange.png",	
	Rarity = 3,
	Name = "Form Change",
	Description = "Whips the front three tiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_DeoxysBoss",
	}
}

function Poke_AlienWhip:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[i]
		ret:push_back(curr) 
	end
	return ret
end

function Poke_AlienWhip:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, 1)
	damage.sSound = "/weapons/sword"
	damage.sAnimation = "alienwhip"..math.random(0, 3).."_"..direction
	ret:AddMelee(p1, damage)
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+1)%4], 1))
	ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[(direction+3)%4], 1))
	return ret
end


Mission_DarkraiBoss = Mission_Boss:new{
	Name = "Darkrai",
	BossPawn = "Poke_DarkraiBoss",
	GlobalSpawnMod = -1,	
	BossText = "Capture Darkrai",
	BallID = -1,
}

function Mission_DarkraiBoss:IsBossDead()
	return (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID)
end

function Mission_DarkraiBoss:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if (not Board:IsPawnAlive(self.BossID)) and Board:IsPawnAlive(self.BallID) then
		if not achievements.Poke_DarkraiCapture:isComplete() then achievements.Poke_DarkraiCapture:addProgress{ complete = true } end
	end
	
	if type(objectives) ~= "table" then
	    objectives = { objectives } 
	end
	
	local total_rep = 0
	local total_possible = 0
	for i,v in ipairs(objectives) do
		total_rep = v.rep + total_rep
		total_possible = v.potential + total_possible
	end
	
	if total_rep == total_possible then
		return "Success"
	elseif total_rep == 0 then
		return "Failure"
	else
		return "Partial"
	end
end


Poke_DarkraiBoss = {
	Health = 7,
	MoveSpeed = 5,
	Image = "Darkrai_B",
	Name = "Darkrai",
	-- ImageOffset = 2,
	SkillList = { "Poke_DarkPulseBoss" },
	SoundLocation = "/enemy/moth_1/",
	ImpactMaterial = IMPACT_FLESH,
	DefaultTeam = TEAM_ENEMY,
	IsPortrait = false,
	Tier = TIER_BOSS,
	IsDeathEffect = true,
	Massive = true,
	Flying = true,
	GetWeapon = DarkVoid,
}
AddPawn("Poke_DarkraiBoss") 

function DarkVoid()
	for i = DIR_START, DIR_END do
		local curr = Pawn:GetSpace() + DIR_VECTORS[i]
		local target = Board:GetPawn(curr)
		if target and target:GetTeam() == TEAM_PLAYER then
			target:SetPowered(false)
			CustomAnim:add(target:GetId(), "sleepAnim")
			GetCurrentMission().SleepTable[target:GetId()] = 2 --when this reaches 0, pawn is active, so 2 stops for 1 turn, 3 for 2 turns...
		end
	end
end

function Poke_DarkraiBoss:GetDeathEffect(point)
	local ball = PAWN_FACTORY:CreatePawn("Poke_MasterBall")
	local mission = GetCurrentMission()
	Board:AddPawn(ball, point)
	mission.BallID = ball:GetId()
	return SkillEffect()
end

Poke_DarkPulseBoss = Skill:new{
	Class = "Enemy",
	Icon = "weapons/DarkPulse.png",	
	Rarity = 3,
	Name = "Dark Pulse",
	Description = "Damage all surrounding tiles.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,
	PowerCost = 0, --AE Change
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_DarkraiBoss",
	}
}

function Poke_DarkPulseBoss:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	return ret
end

function Poke_DarkPulseBoss:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddQueuedAnimation(p1, "darkpulseAnim")
	ret:AddDelay(0.2)
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i]
		ret:AddQueuedDamage(SpaceDamage(curr, self.Damage))
	end
	for i = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
		ret:AddQueuedDamage(SpaceDamage(curr, self.Damage))
	end
	return ret
end