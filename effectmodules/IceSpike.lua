local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local debris = game:GetService("Debris")

local damage = 20

local function weld(y,x)
	local W = Instance.new("Weld")
	W.Name = "Weld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end


module.fire = function(mousehit,hitfunc)	
	local fireball = game.ServerStorage.wabbajack_misc.IceSpike:Clone()
	fireball.Parent = workspace
	local handle = script.Parent.Parent
	fireball.CFrame = handle.CFrame:ToWorldSpace(CFrame.new(0,7,-3))
	fireball.CFrame = CFrame.new(fireball.CFrame.p,mousehit.p)
	fireball.CanCollide = false
	
	
	local vel = Instance.new("BodyVelocity",fireball)
	vel.MaxForce = Vector3.new(1,1,1)*1e16
	vel.Velocity = (mousehit.p - fireball.Position).Unit * 200
	fireball.Velocity = vel.Velocity
	
	local called  = false
	fireball.Touched:Connect( function(part) 		
		if not part.CanCollide then return end
		if called then return end
		called = true
		weld(fireball,part)
		vel:remove()
		fireball.ParticleEmitter.Enabled = false
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		humanoid.Health = humanoid.Health - damage 
		end)
	debris:AddItem(fireball,20)
end


return module
