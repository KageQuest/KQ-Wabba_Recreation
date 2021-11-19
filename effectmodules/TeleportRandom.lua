local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

local damage = 20

module.fire = function(moushit,handle)
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end	
		local hrp = humanoid.Parent.HumanoidRootPart
		local rei = Ray.new(hrp.Position,Vector3.new(math.random()*2-1,math.random()*2-1,math.random()*2-1)*200)
		local part,pos = workspace:FindPartOnRay(rei,hrp.Parent)
		humanoid.Jump = true --jump in case of seat
		hrp.CFrame = CFrame.new(pos.x,pos.y,pos.z)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
