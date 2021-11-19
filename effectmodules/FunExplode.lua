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
		
		local boom = Instance.new("Explosion")
		boom.ExplosionType = Enum.ExplosionType.NoCraters
		boom.BlastRadius = 1
		boom.Position = head.Parent:FindFirstChild("HumanoidRootPart").CFrame.p
		boom.Parent = head.Parent:FindFirstChild("HumanoidRootPart")
		
		local hrpcf = head.Parent.HumanoidRootPart.CFrame
		local remains = ss.Remains:Clone()
		remains.Parent = workspace
		remains.CFrame	= hrpcf:ToWorldSpace(CFrame.new(0,-3,0))
		
		local hrpcf = head.Parent.HumanoidRootPart.CFrame
		local pitchAmount = math.random(1,15)
		local coinAmount = math.random(1,50)
		local purseAmount = math.random(1,10)
		for x=1,pitchAmount do
			local pitch = ss.Pitchfork:Clone()
			pitch.Parent =workspace
			pitch.CFrame = hrpcf+Vector3.new(math.random(-10,10),0,math.random(-10,10))
			pitch.Anchored = false
			debris:AddItem(pitch,60) --delete after 60s
		end
		for x=1,purseAmount do
			local purse = ss.CoinPurse:Clone()
			purse.Parent =workspace
			purse.CFrame = hrpcf+Vector3.new(math.random(-10,10),0,math.random(-10,10))
			purse.Anchored = false
			debris:AddItem(purse,120) --delete in the case the money isnt collected
		end
		for x=1,coinAmount do
			local coin = ss.Coin:Clone()
			coin.Parent =workspace
			coin.CFrame = hrpcf+Vector3.new(math.random(-10,10),0,math.random(-10,10))
			coin.Anchored = false
			debris:AddItem(coin,120) --delete in the case the money isnt collected
		end
		
		debris:AddItem(remains,120)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
