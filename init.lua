--[[	Title: Simple Adventure Status Tracking
		Author: Grimmier
		Description: Simple Adventure Status Tracking
			* Only shows when in an adventure.
			* Auto Closes the Adventure Window in game across all characters if opened outside of the script every 5 seconds.
				ie. first getting adventure or after zoning.
			* Help Icon Tooltip will display Quest Information
			* Clicking on the Help Icon will toggle ingame Adventure Window. no auto close
]]
--Includes
---@type Mq
local mq = require('mq')
Icons = require('mq.ICONS')
---@type ImGui
local ImGui = require 'ImGui'
-- Variables
local AdvWIN = mq.TLO.Window('AdventureRequestWnd')
local guiOpen = false
local eqWinOpen = false
local groupCmd = '/dgae '
--Helpers
local function checkAdv()
	-- check for active adventure timers.Either time to enter dungeon or time to complete.
	if AdvWIN.Child('AdvRqst_EnterTimeLeftLabel').Text() ~= '' then
		return string.format('Time to Enter Left: %s',AdvWIN.Child('AdvRqst_EnterTimeLeftLabel').Text())
	elseif AdvWIN.Child('AdvRqst_CompleteTimeLeftLabel').Text() ~= '' then
		return string.format('Time to Complete Left: %s',AdvWIN.Child('AdvRqst_CompleteTimeLeftLabel').Text())
	else
		-- no active timers, so we are not in an adventure.
		return tostring('No Adventure Started')
	end
end
--GUI
function GUI_AdvStatus(open)
	if guiOpen then
		local show = false
		open, show = ImGui.Begin("SimpleAdventureStatusTracking", open, bit32.bor(ImGuiWindowFlags.NoCollapse,ImGuiWindowFlags.NoTitleBar,ImGuiWindowFlags.AlwaysAutoResize, ImGuiWindowFlags.NoSavedSettings))
		if not show then
			ImGui.End()
			return open
		end
		ImGui.Text("Adventure Status: \t")
		ImGui.SameLine()
		ImGui.Text( AdvWIN.Child('AdvRqst_ProgressTextLabel').Text() or 'None')
		ImGui.SameLine(220)
		ImGui.Text(Icons.MD_HELP_OUTLINE)
		if ImGui.IsItemHovered() then
			if ImGui.IsMouseReleased(0) then
				eqWinOpen = AdvWIN.Open()
				if not eqWinOpen then
					AdvWIN.DoOpen()
					eqWinOpen = true
				else
					AdvWIN.DoClose()
					eqWinOpen = false
				end
			end
			ImGui.BeginTooltip()
			ImGui.PushTextWrapPos(250)
			ImGui.Text("Click to Open InGame\nQuest Information:" )
			ImGui.Separator()
			ImGui.Text(AdvWIN.Child('AdvRqst_NPCText').Text() or 'No Adventure')
			ImGui.PopTextWrapPos()
			ImGui.EndTooltip()
		end
		ImGui.Separator()
		ImGui.Text(checkAdv())
		ImGui.End()
		return open
	end
end

local function startup()
	--check for MQ2EQBC plugin
	if mq.TLO.Plugin('mq2eqbc').IsLoaded() then groupCmd = '/bcaa /' end
	mq.imgui.init('Adventure Status', GUI_AdvStatus)
end

local function loop()
	while true do
		if checkAdv() ~= 'No Adventure Started' then
			guiOpen = true
			-- if ingame window is open and we didn't set the flag close it on all characters. we most likely zoned or just accepted the quest.
			if not eqWinOpen and AdvWIN.Open() then mq.cmdf('/noparse %s/lua parse mq.TLO.Window("AdventureRequestWnd").DoClose()',groupCmd) end
		else
			guiOpen = false
		end
		mq.delay('5s')
	end
end
startup()
loop()