-- luacheck config. WoW runs Lua 5.1.
std = "lua51"
max_line_length = 120
exclude_files = { "node_modules/", ".release/", ".lua/", ".luarocks/", ".install/" }

-- WoW API used by the addons. Add names here as you use them.
read_globals = {
	"C_AddOns",
	"CreateFrame",
	"DEFAULT_CHAT_FRAME",
	"Minimap",
	"UIParent",
	"InCombatLockdown",
	"LibStub",
}

-- Globals the addons are allowed to define.
globals = {
	"OrdaenMinimapDB",
	"SLASH_ORDAENMINIMAP1",
	"SLASH_ORDAENMINIMAP2",
	"SlashCmdList",
}

files["tests/"] = { std = "+busted" }
