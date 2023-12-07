
local this = {}
local scriptPath = mod_loader.mods[modApi.currentMod].scriptPath
local path = scriptPath .."missions/"
local personality = require(scriptPath .."personality")

local missions = {
	"mission_mewtwo",
	"mission_darkrai",
	"mission_deoxys",
}

local function loadMissionDialog(missionId, file)
	local name = file:sub(1, -5)
	local dialog = require(name)
	
	for person, t in pairs(dialog) do
		personality.AddMissionDialog(Personality[person], missionId, t)
	end
end

function this:init(mod)
	for _, mission in ipairs(missions) do
		-- local options = mod_loader.currentModContent[modApi:getCurrentMod().id].options
		-- if options["Enable_"..mission] and options["Enable_"..mission].enabled then
			self[mission] = require(path .. mission)
			self[mission]:init(mod)
		-- else
			-- LOG("disabled "..mission)
		-- end
	end
end

function this:load(mod, options, version)

	for _, mission in ipairs(missions) do
		-- if options["Enable_"..mission] and options["Enable_"..mission].enabled then
			self[mission]:load(mod, options, version)
			loadMissionDialog(self[mission].id, path .. mission .."_dialog.lua")
		-- end
	end
end

return this