local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local hrp = lib.findInAncestry(part,{"HumanoidRootPart"})
		if not hrp then return end
		local caster = script.Parent.Parent.Parent.Parent
		local casterHrp=  caster:WaitForChild("HumanoidRootPart")
		if not casterHrp then return end
		local targetPos = hrp.CFrame
		local catserPos = casterHrp.CFrame
		caster.Humanoid.Jump = true --jump caster in case of seat
		hrp.Parent.Humanoid.Jump = true --jump target in case of seat
		hrp.CFrame = catserPos
		hrp:MakeJoints()
		casterHrp.CFrame = targetPos
		casterHrp:MakeJoints()
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
