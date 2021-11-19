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
		local hrpcf = head.Parent.HumanoidRootPart.CFrame
		local remains = ss.ash:Clone()
		remains.Parent = workspace
		remains.CFrame	= hrpcf:ToWorldSpace(CFrame.new(0,-3,0))
		head.face:remove()
		debris:AddItem(remains,120)
		local parts = lib.allChildsMatching(head.Parent, function(a) return a:IsA("BasePart") end)
		for k,v in pairs(parts) do
			coroutine.wrap(function()
				for i = 1,25 do
					v.Transparency = i/25
					wait()
					end
				end)()
			wait()
		end
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
