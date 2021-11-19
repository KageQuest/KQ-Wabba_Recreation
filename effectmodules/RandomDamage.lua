local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		local damage = math.random(0,humanoid.MaxHealth)
		humanoid.Health = humanoid.Health - damage
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
