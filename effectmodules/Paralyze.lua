local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local para = script.CuffControl --Child client-side local script that forces the player into a "stiff" ragdoll and unable to move
local damage = 20

local debris = game:GetService("Debris")
module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		local p = para:Clone()
		p.Parent = humanoid.Parent
		p.Disabled = false
		local paratimer = 0
		while paratimer < 5 do
			humanoid.Sit = true
			humanoid.PlatformStand = true
			humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
			paratimer = paratimer + wait()
		end
		p:remove()
		humanoid.PlatformStand = false
		humanoid.Sit = false
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
