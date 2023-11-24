local resourcePath = mod_loader.mods[modApi.currentMod].resourcePath
local artilleryArc = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/artilleryArc")
local weaponArmed = require(mod_loader.mods[modApi.currentMod].scriptPath .."libs/weaponArmed")

local files = {
    "Pound.png",
	"Protect.png",
	"Twister.png",
	"Psywave.png",
	"Slam.png",
	"Confusion.png",
	"Kinesis.png",
	"DragonRage.png",
	"Psychic.png",
	"Fly.png",
	"HyperBeam.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/weapons/"..file, resourcePath.."img/weapons/"..file)
end

modApi:appendAsset("img/effects/confusion.png", resourcePath.."img/effects/confusion.png")
modApi:appendAsset("img/effects/psywave_R.png", resourcePath.."img/effects/psywave_R.png")
modApi:appendAsset("img/effects/psywave_U.png", resourcePath.."img/effects/psywave_U.png")
modApi:appendAsset("img/effects/shotup_dragonrage.png", resourcePath.."img/effects/shotup_dragonrage.png")
modApi:appendAsset("img/effects/twister.png", resourcePath.."img/effects/twister.png")

local effects = {
	-- "laser_hyperbeam_hit.png",
	"laser_hyperbeam_R.png",
	"laser_hyperbeam_R1.png",
	"laser_hyperbeam_R2.png",
	-- "laser_hyperbeam_start.png",
	"laser_hyperbeam_U.png",
	"laser_hyperbeam_U1.png",
	"laser_hyperbeam_U2.png",
}
for _, effect in ipairs(effects) do
	modApi:appendAsset("img/effects/".. effect, resourcePath .. "img/effects/" .. effect)
	Location["effects/"..effect] = Point(-12,3)
end
modApi:appendAsset("img/effects/evolution.png", resourcePath.."img/effects/evolution.png")

ANIMS.evolutionAnim = Animation:new{ 	
	Image = "effects/evolution.png",
	PosX = -10, PosY = -5,
	NumFrames = 4,
	Time = 0.2,
	Loop = true,
	Frames = {0, 1, 2, 3, 2, 1, 0}
}

ANIMS.confusionAnim = Animation:new{ 	
	Image = "effects/confusion.png",
	PosX = -10, PosY = -5,
	NumFrames = 4,
	Time = 0.1,
	Loop = false,
	Frames = {0, 1, 2, 3, 0, 1, 2, 3}
}
ANIMS.twisterAnim = Animation:new{ 	
	Image = "effects/twister.png",
	PosX = -10, PosY = -5,
	NumFrames = 5,
	Time = 0.1,
	Loop = false,
}


Poke_Pound = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Pound.png",	
	Rarity = 3,
	Name = "Pound",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 0,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Abra",
	}
}
			
function Poke_Pound:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local damage = SpaceDamage(p2, 1, direction)
	damage.sAnimation = "explopunch1_"..direction
	ret:AddMelee(p1, damage)
	return ret
end

Poke_Slam = Brute_Beetle:new{
	Class = "TechnoVek",
	Icon = "weapons/Slam.png",	
	Rarity = 3,
	Name = "Slam",
	Description = "Strike a target and push it back.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	SelfDamage = 0,
	PathSize = 3,
	PowerCost = 0, --AE Change
	Upgrades = 0,
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,1),
		Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}

function Poke_Slam:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, self.PathSize do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Slam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pathing = PATH_PROJECTILE
	local doDamage = true
	local target = p2
	local distance = p1:Manhattan(target)
	
	if not Board:IsBlocked(target,pathing) then -- dont attack an empty edge square, just run to the edge
		doDamage = false
		target = target + DIR_VECTORS[direction]
	end

	
	local damage = SpaceDamage(target, self.Damage, direction)
	damage.sSound = self.ImpactSound
	
	if distance == 1 and doDamage then
		ret:AddMelee(p1,damage, NO_DELAY)
	else
		ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[direction]), NO_DELAY)--FULL_DELAY)

		local temp = p1 
		while temp ~= target  do 
			temp = temp + DIR_VECTORS[direction]
			if temp ~= target then
				ret:AddDelay(0.06)
			end
		end
		
		if doDamage then ret:AddDamage(damage) end
	
	end
	

	return ret
end

Poke_Protect = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Protect.png",	
	Rarity = 3,
	Name = "Protect",
	Description = "Shield a target.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Free Action" },
	UpgradeCost = { 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Protect_A=Poke_Protect:new{ UpgradeDescription = "Can be used for free once per turn.", FreeShield = true }


function Poke_Protect:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or Board:IsBuilding(curr) then ret:push_back(curr) end
		end
	end
	return ret
end
	
function Poke_Protect:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local mission = GetCurrentMission()        
	local damage = SpaceDamage(p2, 0)
	damage.iShield = EFFECT_CREATE
	if mission and self.FreeShield then
		if not mission.LastProtectTurn then mission.LastProtectTurn = -1 end
		if mission.LastProtectTurn ~= Game:GetTurnCount() then
			ret:AddDelay(0.3)
			ret:AddScript([[
				local self = Point(]].. p1:GetString() .. [[)
				Board:GetPawn(self):SetActive(true)
				Game:TriggerSound("/ui/map/flyin_rewards");
				Board:Ping(self, GL_Color(255, 255, 255));
				GetCurrentMission().LastProtectTurn = Game:GetTurnCount();
			]])
		end
		ret:AddScript("GetCurrentMission().LastProtectTurn = Game:GetTurnCount()")
	end
	ret:AddDamage(damage)
	return ret
end

Poke_Psywave = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Psywave.png",	
	Rarity = 3,
	Name = "Psywave",
	Description = "Send out a psychic projectile. It splits in two when it hits a shield.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Crush Shields" },
	UpgradeCost = { 2, 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,3),
		CustomPawn = "Poke_Mew",
	}
}
Poke_Psywave_A=Poke_Psywave:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psywave_B=Poke_Psywave:new{ UpgradeDescription = "Damages shielded enemies.", CrushShields = true }
Poke_Psywave_AB=Poke_Psywave:new{ Damage = 3, CrushShields = true }


function Poke_Psywave:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	return ret
end

function Poke_Psywave:SplitOnShieldHit(ret, p1, p2, depth)
	if not depth then depth = 0 end
	local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	local damage = SpaceDamage(target, self.Damage)
	local direction = GetDirection(p2-p1)
	local crushShield
	if Board:IsShield(target) then damage.iDamage = 0 end
	if Board:GetPawn(target) and Board:GetPawn(target):IsShield() then
		if self.CrushShields then crushShield = true else damage.iDamage = 0 end
	end
	local delay
	if depth == 0 then delay = PROJ_DELAY else delay = NO_DELAY end
	if crushShield then ret:AddScript(string.format("Board:RemoveShield(%s)", target:GetString())) end
	ret:AddProjectile(p1, damage, "effects/psywave", delay)
	
	if (damage.iDamage == 0 or crushShield) and depth < 3 then 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+1)%4], depth + 1) 
		self:SplitOnShieldHit(ret, target, target + DIR_VECTORS[(direction+3)%4], depth + 1) 
		ret:AddDelay(-1)
	end
	return ret
end
	
function Poke_Psywave:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	-- local target = GetProjectileEnd(p1, p2, PATH_PROJECTILE)
	self:SplitOnShieldHit(ret, p1, p2, 0)
	return ret
end



Poke_DragonRage = LineArtillery:new{
	Class = "TechnoVek",
	Icon = "weapons/DragonRage.png",	
	Rarity = 3,
	Name = "Dragon Rage",
	Description = "Throw a damaging projectile.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 8,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 0,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Target = Point(2,1),
		CustomPawn = "Poke_Dratini",
	}
}

function Poke_DragonRage:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "ExploArt1"
	ret:AddArtillery(p1, damage, "effects/shotup_dragonrage.png", PROJ_DELAY)
	return ret
end
	
Poke_Twister = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Twister.png",	
	Rarity = 3,
	Name = "Twister",
	Description = "Cast a tornado, dealing damage to a target and pushing adjacent tiles clockwise.",
	Push = 1,--TOOLTIP HELPER
	Damage = 1,
	PathSize = 1,	--automatically makes a target area?
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "Push corners" },
	UpgradeCost = { 2,3 },
	LaunchSound = "/weapons/support_wind",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Twister_A=Poke_Twister:new{ UpgradeDescription = "Increases damage by 1 and damages adjacent tiles.", Damage = 2 }
Poke_Twister_B=Poke_Twister:new{ UpgradeDescription = "Also pushes diagonally adjacent tiles.", PushCorners = true }
Poke_Twister_AB=Poke_Twister:new{ Damage = 2, PushCorners = true }

function Poke_Twister:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			ret:push_back(curr)
		end
	end
	return ret
end
	
function Poke_Twister:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(p2, self.Damage)
	damage.sAnimation = "twisterAnim"
	damage.sSound = self.LaunchSound
	if Board:IsBuilding(p2) then damage.iDamage = 0 end
	ret:AddDamage(damage)
	if self.PushCorners then
		for i = DIR_START, DIR_END do
			local curr = p2 + DIR_VECTORS[i] + DIR_VECTORS[(i+1)%4]
			local pushDamage = SpaceDamage(curr, math.max(self.Damage-2, 0), (i+1)%4)
			if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
			ret:AddDamage(pushDamage)
		end
		ret:AddDelay(-1)
	end
	for i = DIR_START, DIR_END do
		local curr = p2 + DIR_VECTORS[i]
		local pushDamage = SpaceDamage(curr, math.max(self.Damage-1, 0), (i+1)%4)
		if Board:IsBuilding(curr) then pushDamage.iDamage = 0 end
		ret:AddDamage(pushDamage)
	end
	return ret
end


Poke_Confusion = Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Confusion.png",	
	Rarity = 3,
	Name = "Confusion",
	Description = "Strike a target with psychic powers, confusing it into changing its attack direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 2,
	PathSize = 1,	--automatically makes a target area?
	ToSpawn = "",
	PowerCost = 0, --AE Change
	Upgrades = 0,
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Abra",
	}
}

function Poke_Confusion:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point)
	for i = DIR_START, DIR_END do
		for j = 1, 8 do
			local curr = point + DIR_VECTORS[i] * j
			if Board:GetPawn(curr) or 
			(self.HitSides and (Board:GetPawn(curr + DIR_VECTORS[(i + 1)%4]) or Board:GetPawn(curr + DIR_VECTORS[(i + 3)%4]))) then 
				ret:push_back(curr) 
			end
		end
	end
	return ret
end

function Poke_Confusion:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	local damage = SpaceDamage(p2, self.Damage, DIR_FLIP)
	damage.sAnimation = "confusionAnim"
	ret:AddSafeDamage(damage)
	if self.HitSides then
		damage.loc = p2 + DIR_VECTORS[(direction + 1)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
		damage.loc = p2 + DIR_VECTORS[(direction + 3)%4]
		if Board:GetPawn(damage.loc) then ret:AddSafeDamage(damage) end
	end
	return ret
end

Poke_Psychic=Poke_Confusion:new{
	Icon = "weapons/Psychic.png",	
	Rarity = 3,
	Name = "Psychic",
	Description = "Strike several targets with psychic powers, confusing them into changing their attack directions.",
	HitSides = true,
	Upgrades = 2,
	UpgradeList = { "+1 Damage", "+1 Damage" },
	UpgradeCost = { 2,3 },
}
Poke_Psychic_A=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_B=Poke_Psychic:new{ UpgradeDescription = "Increases damage by 1.", Damage = 3 }
Poke_Psychic_AB=Poke_Psychic:new{ Damage = 4 }


Poke_Fly=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Fly.png",	
	Rarity = 3,
	Name = "Fly",
	Description = "Fly up, then swoop down on a target for massive damage.",
	Push = false,--TOOLTIP HELPER
	Damage = 3,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 2,
	UpgradeList = { "Global", "Push" },
	UpgradeCost = { 2,2 },
	ZoneTargeting = ZONE_DIR,
	ArtilleryHeight = 40,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Dratini",
	}
}
Poke_Fly_A=Poke_Fly:new{ UpgradeDescription = "Can target any tile.", Global = true }
Poke_Fly_B=Poke_Fly:new{ UpgradeDescription = "Pushes adjacent tiles, except the target's, on landing.", Push = true }
Poke_Fly_AB=Poke_Fly:new{ Global = true, Push = true }

function Poke_Fly:GetTargetArea(p1)
	local ret = PointList()
	if self.Global then
		for _, tile in ipairs(Board) do
			local unblocked = false
			if Board:IsBlocked(tile, PATH_PROJECTILE) then
				for i = DIR_START, DIR_END do
					local curr = tile + DIR_VECTORS[i]
					if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
				end
				if unblocked then ret:push_back(tile) end
			else
				ret:push_back(tile)
			end
		end
	else
		for dir = DIR_START, DIR_END do
			for i = 1,7 do
				local tile = p1 + DIR_VECTORS[dir]*i
				if Board:IsBlocked(tile, PATH_PROJECTILE) then
					for j = DIR_START, DIR_END do
						local curr = tile + DIR_VECTORS[j]
						if not Board:IsBlocked(curr, PATH_PROJECTILE) then unblocked = true break end
					end
					if unblocked then ret:push_back(tile) end
				else
					ret:push_back(tile)
				end
			end
		end
	end
	return ret
end

function Poke_Fly:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	--We only do two click weapon stuff if there is a pawn to strike in the target tile.
	for i = DIR_START,DIR_END do
		--for each tile adjacent to the pawn
		local curr = p2 + DIR_VECTORS[i]
		if Board:IsValid(curr) and not Board:IsBlocked(curr, PATH_PROJECTILE) then 
			--if valid and something the user can stand on, we return it
			ret:push_back(curr) 
		end
	end
	
	return ret	
end

function Poke_Fly:IsTwoClickException(p1,p2)
	if not Board:IsBlocked(p2, PATH_PROJECTILE) then return true end	--we only do two click weapon stuff if there is a pawn in p2
	return false
end

function Poke_Fly:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local pawn = Board:GetPawn(p1)
	local distance = p1:Manhattan(p2)
	local direction = GetDirection(p2 - p1)
	local move = PointList()
	move:push_back(p1)
	move:push_back(p2)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p2,"Emitter_Burst_$tile",DIR_NONE)
	if self.Push then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p2 + DIR_VECTORS[i], 0)
			 dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			ret:AddDamage(dam)
		end
	end
	return ret
end

function Poke_Fly:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	
	local move = PointList()
	move:push_back(p1)
	move:push_back(p3)
	ret:AddBurst(p1,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddLeap(move, FULL_DELAY)
	ret:AddBurst(p3,"Emitter_Burst_$tile",DIR_NONE)
	ret:AddDamage(SpaceDamage(p2, self.Damage))
	if self.Push then
		for i = DIR_START, DIR_END do
			local dam = SpaceDamage(p3 + DIR_VECTORS[i], 0)
			 dam.iPush = i
			dam.sAnimation = PUSH_ANIMS[i]
			if dam.loc ~= p2 then ret:AddDamage(dam) end
		end
	end
	return ret
end

Poke_Kinesis=Skill:new{
	Class = "TechnoVek",
	Icon = "weapons/Kinesis.png",	
	Rarity = 3,
	Name = "Kinesis",
	Description = "Use psychic powers to shove a target in any direction.",
	Push = 1,--TOOLTIP HELPER
	Damage = 0,
	PathSize = 1,	--automatically makes a target area?
	TwoClick = true,
	PowerCost = 0, --AE Change
	Upgrades = 1,
	UpgradeList = { "Fling" },
	UpgradeCost = { 3 },
	LaunchSound = "/weapons/charge",
	ImpactSound = "/weapons/charge_impact",
	ZoneTargeting = ZONE_DIR,
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,3),
		Target = Point(2,2),
		Enemy1 = Point(1, 2),
		Enemy2 = Point(2, 2),
		Enemy3 = Point(3, 2),
		CustomPawn = "Poke_Abra",
	}
}
Poke_Kinesis_A=Poke_Kinesis:new{ UpgradeDescription = "Can fling targets as far as possible.", Push = 2 }


function Poke_Kinesis:GetTargetArea(p1)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		for i = 1,7 do
			local point2 = p1 + DIR_VECTORS[dir]*i
			if Board:GetPawn(point2) and not Board:GetPawn(point2):IsGuarding() then ret:push_back(point2) end
		end
	end
	return ret
end

function Poke_Kinesis:GetSecondTargetArea(p1, p2)
	local ret = PointList()
	if not Board:GetPawn(p2) then return ret end
	for i = DIR_START,DIR_END do
		for j = 1, self.Push do
			local curr = p2 + DIR_VECTORS[i] * j
			if Board:IsValid(curr) then ret:push_back(curr) end
			if Board:IsBlocked(curr, PATH_PROJECTILE) then break end
		end
	end
	
	return ret	
end

function Poke_Kinesis:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2-p1)
	ret:AddDamage(SpaceDamage(p2, 0, direction))
	return ret
end

function Poke_Kinesis:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local direction = GetDirection(p3-p2)
	local distance = p2:Manhattan(p3)
	if distance == 1 then
		ret:AddDamage(SpaceDamage(p2, 0, direction))
	else
		local target = GetProjectileEnd(p2, p3)
		local hurt = true
		if not Board:IsBlocked(target, PATH_PROJECTILE) then hurt = false else target = target - DIR_VECTORS[direction] end
		ret:AddCharge(Board:GetSimplePath(p2, target), FULL_DELAY)
		if hurt then
			ret:AddDamage(SpaceDamage(target, 1))
			ret:AddDamage(SpaceDamage(target + DIR_VECTORS[direction], 1))
		end
	end
	return ret
end

Poke_HyperBeam = LaserDefault:new{
	Class = "TechnoVek",
	Icon = "weapons/HyperBeam.png",
	Name = "Hyper Beam",
	Description = "Cast a devastating beam of energy. Completely exhausts the user; they must spend the rest of the mission asleep.",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/props/final_bomb_explode",
	Damage = 3,
	PowerCost = 0, --AE Change
	MinDamage = 3,
	FriendlyDamage = true,
	ZoneTargeting = ZONE_DIR,
	LaserArt = "effects/laser_hyperbeam",
	-- LaserArt = "effects/laser1",
	Upgrades = 0,
--	UpgradeList = { "Ally Immune", "+1 Damage" },
	-- UpgradeCost = { 1,3 },
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Friendly = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,0),
		CustomPawn = "Poke_Dratini",
	}
}
function Poke_HyperBeam:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local target = p1 + DIR_VECTORS[direction]
	ret:AddScript("Board:StartShake(1)")
	ret:AddScript(string.format("Game:TriggerSound(%q)", self.LaunchSound))
	self:AddLaser(ret, target, direction)
	ret:AddScript(string.format("Board:GetPawn(%s):SetPowered(false)", p1:GetString()))
	ret:AddScript(string.format("Board:GetPawn(%s):SetCustomAnim(%q)", p1:GetString(), "Poke_Dragonite_sleep"))
	return ret
end