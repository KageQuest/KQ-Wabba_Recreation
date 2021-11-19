local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local head = lib.findInAncestry(part,{"Head"})
		if not head then return end
		head:BreakJoints()
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
