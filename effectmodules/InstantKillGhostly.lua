local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local ss = game.ServerStorage:FindFirstChild("wabbajack_misc")

local debris = game:GetService("Debris")

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local head = lib.findInAncestry(part,{"Head"})
		if not head then return end
		head:BreakJoints()
		local parts = lib.allChildsMatching(head.Parent, function(a) return a:IsA("BasePart") end)
		for k,v in pairs(parts) do
			if v.Name ~="Remains" then
				v.Transparency = 1
			end
		end
		local hrpcf = head.Parent.HumanoidRootPart.CFrame
		local remains = ss.Remains:Clone()
		remains.Parent = workspace
		remains.CFrame	= hrpcf:ToWorldSpace(CFrame.new(0,-3,0))
		head.face:remove()
		debris:AddItem(remains,120)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
