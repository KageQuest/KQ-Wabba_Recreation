local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local head = lib.findInAncestry(part,{"Head"})
		if not head then return end
		head:BreakJoints()
		wait()
		local cframe = head.CFrame
		cframe = cframe:ToWorldSpace(CFrame.new(0,5,0))
		head.CFrame = cframe
		head.Velocity = Vector3.new(0,100,0)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
