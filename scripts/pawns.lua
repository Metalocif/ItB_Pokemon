-- https://sprites.pmdcollab.org/
-- Repository of Pokemon sprites, roughly ItB-style.
-- It also has portraits but they are not the right size (and I couldn't figure out how to change portraits on evo anyway).

-- Feel free to steal this code to make more Pokemon stuff or just upgradeable mechs.
-- I check pilot level, but you can check anything - either game variables like the current island, or stuff you keep track of yourself.
-- The fields I use for evolution stuff are:
-- HasEvolutions: a table of two booleans, one for level 1, one for level 2; if you made a Pokemon that evolves on level 2 only, it'd be {false, true}
-- EvoGraphics: lists the graphics of evolved forms; nothing is listed for level 0, which is convenient since Lua tables start at 1.
-- EvoForget: lists the weapons to remove on evolution. Max one weapon to forget per level.
-- EvoLearn: lists the weapons to learn on evolution. You can learn more than one per level; if they overflow into slots 3+ they seem to get removed randomly.
-- EvoNames: solely here for the alert messages.
-- KeepAdding: weapons to keep adding to the pawn at the start of each mission, since they seem to get removed otherwise. You can't upgrade these.
-- HealthAtLevel: sets the pawn's base health to that value at that level.
-- BecomeFlyingAtLevel: makes the pawn flying at that level.
--   o It would make more sense for the above two to be a table of table of functions to run if we had a ton of such possibilities. 

local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mechPath = mod_loader.mods[modApi.currentMod].resourcePath .."img/units/player/"
local files = {
    "Abra.png",
    "Abra_a.png",
    "Abra_w.png",
    -- "Abra_w_broken.png",
    "Abra_broken.png",
    "Abra_ns.png",
    "Abra_h.png",
	
	"Kadabra.png",
    "Kadabra_a.png",
    "Kadabra_w.png",
    -- "Kadabra_w_broken.png",
    "Kadabra_broken.png",
    "Kadabra_ns.png",
    "Kadabra_h.png",
	
	"Alakazam.png",
    "Alakazam_a.png",
    -- "Alakazam_w.png",
    -- "Alakazam_w_broken.png",
    "Alakazam_broken.png",
    "Alakazam_ns.png",
    "Alakazam_h.png",
	
	"Dratini.png",
    "Dratini_a.png",
    "Dratini_w.png",
    -- "Dratini_w_broken.png",
    "Dratini_broken.png",
    "Dratini_ns.png",
    "Dratini_h.png",
	
	"Dragonair.png",
    "Dragonair_a.png",
    "Dragonair_w.png",
    -- "Dragonair_w_broken.png",
    "Dragonair_broken.png",
    "Dragonair_ns.png",
    "Dragonair_h.png",
	
	"Dragonite.png",
    "Dragonite_a.png",
    -- "Dragonite_w.png",
    -- "Dragonite_w_broken.png",
    "Dragonite_broken.png",
    "Dragonite_ns.png",
    "Dragonite_h.png",
	"Dragonite_sleep.png",	--only here for Hyper Beam & because it's cute
    
    "Mew.png",
    "Mew_a.png",
    -- "Mew_w.png",
    -- "Mew_w_broken.png",
    "Mew_broken.png",
    "Mew_ns.png",
    "Mew_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, mechPath.. file)
end

local a=ANIMS
a.Poke_Abra =a.MechUnit:new{Image="units/player/Abra.png", PosX = -18, PosY = -9}
a.Poke_Abraa = a.MechUnit:new{Image="units/player/Abra_a.png",  PosX = -13, PosY = -4, NumFrames = 4 }
a.Poke_Abraw = a.MechUnit:new{Image="units/player/Abra_w.png", PosX = -13, PosY = 12}
a.Poke_Abra_broken = a.MechUnit:new{Image="units/player/Abra_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Abraw_broken = a.MechUnit:new{Image="units/player/Abra_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Abra_ns = a.MechIcon:new{Image="units/player/Abra_ns.png"}

a.Poke_Kadabra =a.MechUnit:new{Image="units/player/Kadabra.png", PosX = -18, PosY = 2}
a.Poke_Kadabraa = a.MechUnit:new{Image="units/player/Kadabra_a.png",  PosX = -18, PosY = 2, NumFrames = 4 }
a.Poke_Kadabraw = a.MechUnit:new{Image="units/player/Kadabra_w.png", PosX = -13, PosY = 10}
a.Poke_Kadabra_broken = a.MechUnit:new{Image="units/player/Kadabra_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Kadabraw_broken = a.MechUnit:new{Image="units/player/Kadabra_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Kadabra_ns = a.MechIcon:new{Image="units/player/Kadabra_ns.png"}

a.Poke_Alakazam =a.MechUnit:new{Image="units/player/Alakazam.png", PosX = -18, PosY = -9}
a.Poke_Alakazama = a.MechUnit:new{Image="units/player/Alakazam_a.png",  PosX = -18, PosY = -9, NumFrames = 8 }
a.Poke_Alakazamw = a.MechUnit:new{Image="units/player/Alakazam_w.png", PosX = -18, PosY = -2}
a.Poke_Alakazam_broken = a.MechUnit:new{Image="units/player/Alakazam_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Alakazamw_broken = a.MechUnit:new{Image="units/player/Alakazam_w_broken.png", PosX = -18, PosY = -2 }
a.Poke_Alakazam_ns = a.MechIcon:new{Image="units/player/Alakazam_ns.png"}


a.Poke_Dratini =a.MechUnit:new{Image="units/player/Dratini.png", PosX = -15, PosY = -2}
a.Poke_Dratinia = a.MechUnit:new{Image="units/player/Dratini_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dratiniw = a.MechUnit:new{Image="units/player/Dratini_w.png", PosX = -15, PosY = 4}
a.Poke_Dratini_broken = a.MechUnit:new{Image="units/player/Dratini_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dratiniw_broken = a.MechUnit:new{Image="units/player/Dratini_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dratini_ns = a.MechIcon:new{Image="units/player/Dratini_ns.png"}

a.Poke_Dragonair =a.MechUnit:new{Image="units/player/Dragonair.png", PosX = -15, PosY = -2}
a.Poke_Dragonaira = a.MechUnit:new{Image="units/player/Dragonair_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dragonairw = a.MechUnit:new{Image="units/player/Dragonair_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonair_broken = a.MechUnit:new{Image="units/player/Dragonair_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonairw_broken = a.MechUnit:new{Image="units/player/Dragonair_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonair_ns = a.MechIcon:new{Image="units/player/Dragonair_ns.png"}

a.Poke_Dragonite =a.MechUnit:new{Image="units/player/Dragonite.png", PosX = -15, PosY = -2}
a.Poke_Dragonitea = a.MechUnit:new{Image="units/player/Dragonite_a.png",  PosX = -15, PosY = -2, NumFrames = 4 }
a.Poke_Dragonitew = a.MechUnit:new{Image="units/player/Dragonite_w.png", PosX = -15, PosY = 4}
a.Poke_Dragonite_broken = a.MechUnit:new{Image="units/player/Dragonite_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Dragonitew_broken = a.MechUnit:new{Image="units/player/Dragonite_w_broken.png", PosX = -15, PosY = 4 }
a.Poke_Dragonite_ns = a.MechIcon:new{Image="units/player/Dragonite_ns.png"}
a.Poke_Dragonite_sleep = a.MechUnit:new{Image="units/player/Dragonite_sleep.png", PosX = -15, PosY = -12, NumFrames = 2, Time = 1 }


a.Poke_Mew =a.MechUnit:new{Image="units/player/Mew.png", PosX = -20, PosY = -4}
a.Poke_Mewa = a.MechUnit:new{Image="units/player/Mew_a.png",  PosX = -20, PosY = -4, NumFrames = 4 }
a.Poke_Meww = a.MechUnit:new{Image="units/player/Mew_w.png", PosX = -17, PosY = 2}
a.Poke_Mew_broken = a.MechUnit:new{Image="units/player/Mew_broken.png", PosX = -15, PosY = -2 }
-- a.Poke_Meww_broken = a.MechUnit:new{Image="units/player/Mew_w_broken.png", PosX = -20, PosY = 2 }
a.Poke_Mew_ns = a.MechIcon:new{Image="units/player/Mew_ns.png"}

modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Abra.png", path .."img/portraits/pilots/Pilot_Poke_Abra.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Dratini.png", path .."img/portraits/pilots/Pilot_Poke_Dratini.png")
modApi:appendAsset("img/portraits/pilots/Pilot_Poke_Mew.png", path .."img/portraits/pilots/Pilot_Poke_Mew.png")

CreatePilot{
	Id = "Pilot_Poke_Abra",
	Personality = "Vek",
	Name = "Sabrina",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Dratini",
	Personality = "Vek",
	Name = "Lance",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}
CreatePilot{
	Id = "Pilot_Poke_Mew",
	Personality = "Vek",
	Name = "Blue",
	Sex = SEX_VEK,
	Skill = "Survive_Death",
	Rarity = 0,
	Blacklist = {"Invulnerable", "Popular"},
}

Poke_Abra= Pawn:new{
	Name = "Sabrina",
	Class = "TechnoVek",
	Health = 1,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Teleporter = true,
	Image = "Poke_Abra",
	SkillList = {"Poke_Pound"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Kadabra", "Poke_Alakazam" },
	EvoForget = { "Poke_Pound", "Poke_Confusion" },
	EvoLearn = { { "Poke_Confusion", "Poke_Kinesis" }, { "Poke_Psychic" } },
	EvoNames = { "Abra", "Kadabra", "Alakazam" },
	HealthAtLevel = { 2, 2 },
	BecomeFlyingAtLevel = 2,
}
Poke_Dratini = Pawn:new{
	Name = "Lance",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 3,
	Massive = true,
	Corpse = true,
	Image = "Poke_Dratini",
	SkillList = {"Poke_DragonRage", "Poke_Slam"},
	SoundLocation = "/enemy/blobber_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	HasEvolutions = { true, true },
	EvoGraphics = { "Poke_Dragonair", "Poke_Dragonite" },
	EvoForget = { "Poke_DragonRage", "Poke_Slam" },
	EvoLearn = { { "Poke_Twister" }, { "Poke_Fly" } },
	EvoNames = { "Dratini", "Dragonair", "Dragonite" },
	KeepAdding = { "", "Poke_HyperBeam" },
	HealthAtLevel = { 2, 4 },
	BecomeFlyingAtLevel = 2,
}
Poke_Mew = Pawn:new{
	Name = "Blue",
	Class = "TechnoVek",
	Health = 2,
	MoveSpeed = 4,
	Massive = true,
	Corpse = true,
	Flying = true,
	Image = "Poke_Mew",
	SkillList = {"Poke_Psywave", "Poke_Protect"},
	SoundLocation = "/enemy/jelly_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
}