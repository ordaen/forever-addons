-- Loads an addon file the way WoW does: as a chunk called with (addonName, namespaceTable).
local function loadAddonFile(path)
	local ns = {}
	assert(loadfile(path))("MinimapCompartment", ns)
	return ns
end

describe("IsMinimapButtonName", function()
	local ns = loadAddonFile("addons/MinimapCompartment/Names.lua")

	it("accepts typical addon minimap button names", function()
		for _, name in ipairs({
			"LibDBIcon10_Details",
			"AtlasLootMinimapButton",
			"Questie_MinimapFrame",
			"Foo-Minimap-Button",
			"SomeAddonMinimap",
		}) do
			assert.is_true(ns.IsMinimapButtonName(name), name)
		end
	end)

	it("rejects names ending in digits", function()
		assert.is_false(ns.IsMinimapButtonName("HandyNotesPin12"))
		assert.is_false(ns.IsMinimapButtonName("SomeMinimapButton3"))
	end)

	it("rejects unrelated and missing names", function()
		assert.is_false(ns.IsMinimapButtonName("MinimapZoomIn"))
		assert.is_false(ns.IsMinimapButtonName(""))
		assert.is_false(ns.IsMinimapButtonName(nil))
	end)
end)
