local mod = modApi.currentMod
local path = mod_loader.mods[mod].scriptPath
local this = {id = "Mission_Poke_Shaymin"}
local corpMissions = require(path .."corpMissions")

Mission_Poke_Shaymin = Mission_Infinite:new{
	Name = "Tainted Field",
	Objectives = {Objective("Protect Shaymin",1), Objective("Remove all A.C.I.D. on the board",1),},
	hasAcid = true,
}

function Mission_Poke_Shaymin:StartMission()
	local pawn = PAWN_FACTORY:CreatePawn("Poke_ShayminHelper")
	self.shayminId = pawn:GetId()
	Board:SpawnPawn(pawn)
	local acidCount = 0
	while acidCount <= 10 do
		local tile = Point(math.random(0, 7), math.random(0, 7))
		if not Board:IsBlocked(tile, PATH_PROJECTILE) and not Board:GetTerrain(tile) == TERRAIN_WATER and not Board:GetTerrain(tile) == TERRAIN_HOLE and not Board:GetTerrain(tile) == TERRAIN_ACID then
			Board:SetAcid(tile)
			acidCount = acidCount + 1
		end
	end
end

function Mission_Poke_Shaymin:GetDestroyedCount()
	if not Board:IsPawnAlive(self.shayminId) then
		return 1
	end
	return 0
end

function Mission_Poke_Shaymin:UpdateObjectives()
	local shayminAlive = Board:IsPawnAlive(self.shayminId) and OBJ_STANDARD or OBJ_FAILED
	local hasAcid = false
	for _, tile in ipairs(Board) do
		if Board:IsAcid(tile) then hasAcid = true break end
	end
	if not hasAcid then self.hasAcid = false end
	local acidStatus = hasAcid and OBJ_COMPLETE or OBJ_STANDARD
	Game:AddObjective("Protect Shaymin", shayminAlive)	
	Game:AddObjective("Remove 8 tiles of A.C.I.D.", acidStatus)	
end


function Mission_Poke_Shaymin:GetCompletedObjectives()
	if Board:IsPawnAlive(self.Target) then
		return self.Objectives:Failed()
	end
	return self.Objectives
end

function Mission_Poke_Shaymin:GetCompletedStatus()
	local objectives = self:GetCompletedObjectives()
	
	if Board:IsPawnAlive(self.shayminId) then
		if not achievements.Poke_ShayminCapture:isComplete() then achievements.Poke_ShayminCapture:addProgress{ complete = true } end
	end
	
	local ret = copy_table(self.Objectives)
	
	if not Board:IsPawnAlive(self.shayminId) then
		ret[1] = ret[1]:Failed()
	end
	
	if self.hasAcid then
		ret[2] = ret[2]:Failed()
	end
end

--------------------------------------------------------------------

--------------------------------------------------------------------

function this:init(mod)	

end

function this:load(mod, options, version)
	corpMissions.Add_Missions_High("Mission_Poke_Shaymin", "Meridia")
end

return this