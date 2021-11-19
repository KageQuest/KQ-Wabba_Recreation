local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

local damage = 20

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		if humanoid.Health >= damage then
			humanoid.Health = humanoid.Health - damage
		elseif humanoid.Health < damage then
			damage = humanoid.Health
			humanoid.Health = humanoid.Health - damage
		end
		local caster = script.Parent.Parent.Parent.Parent
		local casterHumanoid =  caster:WaitForChild("Humanoid")
		if not casterHumanoid then return end
		casterHumanoid.Health = casterHumanoid.Health + damage
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
