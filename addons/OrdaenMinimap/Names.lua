-- Pure logic, no WoW API: unit-tested by tests/OrdaenMinimap/names_spec.lua.
local _, ns = ...

-- Lua patterns have no alternation, so the MBB regex
-- `MinimapButton|MinimapFrame|MinimapIcon|[-_]Minimap[-_]|Minimap$|^LibDBIcon10_` is a list.
local BUTTON_NAME_PATTERNS = {
	"MinimapButton",
	"MinimapFrame",
	"MinimapIcon",
	"[-_]Minimap[-_]",
	"Minimap$",
	"^LibDBIcon10_",
}

--- Whether a Minimap child frame with this name looks like an addon's minimap button.
---@param name string|nil
---@return boolean
function ns.IsMinimapButtonName(name)
	if type(name) ~= "string" or name == "" then
		return false
	end
	-- Names ending in digits are usually generated (pins, pooled frames), not addon buttons.
	if name:find("%d$") then
		return false
	end
	for _, pattern in ipairs(BUTTON_NAME_PATTERNS) do
		if name:find(pattern) then
			return true
		end
	end
	return false
end
