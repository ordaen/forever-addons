local addonName, ns = ...

local function Print(...)
	local parts = {}
	for i = 1, select("#", ...) do
		parts[i] = tostring((select(i, ...)))
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99" .. addonName .. "|r: " .. table.concat(parts, " "))
end
ns.Print = Print

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	MinimapCompartmentDB = MinimapCompartmentDB or {}
	local version = C_AddOns.GetAddOnMetadata(addonName, "Version") or "?"
	Print("v" .. version .. " loaded. Type /mc for commands.")
end)

SLASH_MINIMAPCOMPARTMENT1 = "/mc"
SlashCmdList.MINIMAPCOMPARTMENT = function(msg)
	Print("Hello from", addonName, msg ~= "" and ("(" .. msg .. ")") or "")
end
