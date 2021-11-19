local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local ss = game.ServerStorage:FindFirstChild("wabbajack_misc")

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local head = lib.findInAncestry(part,{"Head"})
		if not head then return end
		head:BreakJoints()
		local parts = lib.allChildsMatching(head.Parent, function(a) return a:IsA("BasePart") end)
		for k,v in pairs(parts) do
			if v.Name ~= "Handle" then
				v.Transparency = 1
			end
		end
		pcall(function() head.face:remove() end)
		local amount = math.random(3,15)
		for x=1,amount do
			local hrpcf = head.Parent.HumanoidRootPart.CFrame
			local cheese = ss.Food_CheeseWheel:Clone()
			cheese.Parent =workspace
			cheese.Handle.CFrame = hrpcf+Vector3.new(math.random(-10,10),0,math.random(-10,10))
			cheese.Handle.Anchored = false
		end
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
