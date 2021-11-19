local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local ss = game.ServerStorage:FindFirstChild("wabbajack_misc")

module.fire = function(moushit,handle)
	
	local caster = script.Parent.Parent.Parent.Parent
	local casterHumanoid = caster:WaitForChild("Humanoid")
	if not casterHumanoid then return end
	local parts = lib.allChildsMatching(caster, function(a) return a:IsA("BasePart") and a.Name ~= "HumanoidRootPart" and a.Name ~= "effect" end)
	for k,v in pairs(parts) do
		v.Transparency = 1
		if v.Name == "Head" then
			v.face.Transparency = 1
		end
	end
	wait(30)
	for k,v in pairs(parts) do
		v.Transparency = 0
		if v.Name == "Head" then
			v.face.Transparency = 0
		end
	end
end

return module
