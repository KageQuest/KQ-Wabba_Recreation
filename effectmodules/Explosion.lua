local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local head = lib.findInAncestry(part,{"Head"})
		if not head then return end
		head:BreakJoints()
		local boom = Instance.new("Explosion")
		boom.ExplosionType = Enum.ExplosionType.NoCraters
		boom.BlastRadius = 1
		boom.Position = head.Parent:FindFirstChild("HumanoidRootPart").CFrame.p
		boom.Parent = head.Parent:FindFirstChild("HumanoidRootPart")
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
