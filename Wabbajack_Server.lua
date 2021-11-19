--This is a "Server Script" inside of the tools "Handle" part.
--It handles all of the server-side processes for the Wabbajack tool.

local lib = require(script.Parent.aaadddLib) --Library file, kindly provided by a friend known as "aaaddd" on Roblox. It is unavailable for redistribution, but some of its functions are required so I will be leaving its references in this script.
local wabba = require(script.Parent.WABBAMOD) --Module File; See "WABBAMOD" file in this repo.

--This loads in all of the effect modules; Each module has the logic for its own "effect" caused by the Wabbajack tool.
local effects = {}
do --require the effects in
	for k,v in pairs(script.Parent.effectmodules:GetChildren()) do
		local eff = require(v)
		table.insert(effects,eff)
	end
end

coroutine.wrap(wabba.effect)(script.Parent.Parent.effect.BillboardGui.Frame.ImageLabel)

script.Parent.WABBAJACK.OnServerEvent:Connect(function(player,arg) --This function is called on server "fire"; AKA when a client makes a request to the server
	local char = script.Parent.Parent.Parent
	local toolholder = game.Players:GetPlayerFromCharacter(char)
	if not toolholder then return end
	if toolholder ~= player then return end
	
	local effect = effects[math.random(1,#effects)] --This is where the effect is randomly picked
	script.Parent.fire:Play() --In this instance, "fire" is a sound file that is played
	effect.fire(arg,script.Parent) --Call the actual effect logic. See "/effectmodules/" file in this repo to look at all the different possible effects
end)

script.Parent.effect.OnServerEvent:Connect(function(player,arg) --This function makes an image of the effect visible in the Wabbajack tool. For all intents and purposes, the "effect" in this case is actually the projectile that is fired from the tool.
	script.Parent.Parent.effect.BillboardGui.Enabled = arg
end)

if script.Parent:FindFirstChild("wabbajack_misc") and not game.ServerStorage:FindFirstChild("wabbajack_misc") then --This conditional checks to see if the folder "wabbajack_misc" exists in Server Storage. If not, it moves it there.
	script.Parent.wabbajack_misc.Parent = game.ServerStorage
end
