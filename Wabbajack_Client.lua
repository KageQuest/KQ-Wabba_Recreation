--This is a "Local Script" inside of the tools "Handle" part.
--It handles all of the client-side functionality for the Wabbajack tool.

tool = script.Parent.Parent --The actual "tool" item; This is used by Roblox to determine if the object is a "tool" that can exist inside a players backpack.


local input = game:GetService("UserInputService") --This is a top-level service to handle user input, such as mouse and keyboard strokes

local keys_debounced = {} --Tracks keypresses that are new to this polling cycle, since UserInputState doesnt seem to work when polling
local keys_lastcycle = {} --Keypresses from last polling cycle, required to generate the debounce list
local b1d_raw = false --Raw mouse down from event hooks
local b1d = false --Mouse button 1 down, always false when typing or tabbed out
local typing = false --True when user is typing something in either a text box or game chat
local tabbedOut = false --True when user is tabbed out and using another program than roblox.

local mouse = game.Players.LocalPlayer:getMouse()
local b1d_debounced = false --Mouse-edge detector
local b1d_lastcycle = false --Mouse state from the previous cycle
local b1d_timer = 0 --Timer used for measuring how long the mouse has been held down
local canfire = false --Flag indicating if the fireball will be cast when the mouse is released, controlled by the b1d_timer timer

local equipped = false --Tool equip flag

--This function is called when the tool is "equipped"/held by the player
local function onEquip()
	tool.Handle.draw:Play() --Plays a sound
	equipped = true 
end
--This function is called when the tool is "un-equipped"/put away by the player
local function onUnequip()
	tool.Handle.sheathe:Play() --Plays a sound
	equipped = false
end

tool.Equipped:Connect(onEquip)
tool.Unequipped:Connect(onUnequip)

do --Typing and tab-out protection events
	input.TextBoxFocused:connect(function() --Is user typing?
		typing = true
	end)
	input.TextBoxFocusReleased:connect(function()
		wait()
		typing = false
	end)
	input.WindowFocusReleased:connect(function() --Is user tabbed out?
		tabbedOut = true
	end)
	input.WindowFocused:connect(function()
		tabbedOut = false
end)
end

do --Mouse click
	mouse.Button1Down:connect(function()
		b1d_raw = true
	end)
	mouse.Button1Up:connect(function()
		b1d_raw = false
	end)
end


function getkeys() --User input
	local keys = input:GetKeysPressed()
	if tabbedOut or typing then return {} end
	local keys2 = {}
	for k,v in pairs(keys) do
		keys2[v.KeyCode] = v
	end
	keys_debounced = {} --Clear debounced key list
	for k,v in pairs(keys2) do --Generate debounced key list
		if not keys_lastcycle[k] then keys_debounced[k] = v end --Enter into debounced key list if not found in last cycle (therefore keypress is new)
	end
	keys_lastcycle = keys2 --Update last cycle keys
	b1d = b1d_raw and not (tabbedOut or typing)
	b1d_debounced = b1d and not b1d_lastcycle
	b1d_lastcycle = b1d
	return keys2
end

--This spawns a new "thread" as to not hault any other process on the client
coroutine.wrap(function()
	while true do
		local dt = wait()
		local keys = getkeys()
		if equipped then --Only process if the tool is equipped
			script.Parent.effect:FireServer(b1d) --Sends a message to the server that Mouse Button 1 is being held
			b1d_timer = b1d_debounced and 0 or b1d_timer --Reset the timer if the mouse just clicked this polling cycle
			b1d_timer = b1d and b1d_timer + dt or b1d_timer --Increment the timer while the mouse is being held down
			canfire = b1d_timer > 0.5 --If the mouse has been held for over .5 seconds, the player can now fire
			if b1d_debounced then script.Parent.charge:Play() end
			if not b1d then script.Parent.charge:Stop() end
			if canfire and not b1d then
				b1d_timer = 0
				script.Parent.WABBAJACK:FireServer(mouse.hit) --Sends a message to the server to launch the fireball/"effect" towards the mouse's raycast position
			end
		end
	end
end)()
