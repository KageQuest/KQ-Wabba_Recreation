local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local debris = game:GetService("Debris")
local damage = 75
local tau = 2*math.pi
local bigdist = 5
local smalldist = 2
module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		damage = math.random(50,150)
		local cf = CFrame.new(proj.CFrame.p)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		local hrp = lib.findInAncestry(part,{"HumanoidRootPart"})
		if humanoid then
			humanoid.Health = humanoid.Health - damage
			if hrp then cf = hrp.CFrame:ToWorldSpace(CFrame.new(0,-3,0)) end
		end
		local lightning = game.ServerStorage.wabbajack_misc.lightning:clone()
		lightning.Parent = workspace
		lightning.CFrame = cf
		lightning.Beam.Enabled = true
		lightning.shout:Play()
		lightning.static:Play()
		lightning.thunder:Play()
		for i = 1, math.random(3,5) do
			local rotcf = CFrame.new(math.random()*bigdist-(bigdist/2),math.random()*bigdist-(bigdist/4),math.random()*bigdist-(bigdist/2)) * CFrame.Angles(math.random()*tau,math.random()*tau,math.random()*tau)
			local longboi = game.ServerStorage.wabbajack_misc.sparksbig:clone()
			longboi.Parent = lightning
			longboi.animate.Disabled = false
			longboi.CFrame = cf:ToWorldSpace(rotcf)
		end
		for i = 1, math.random(3,5) do
			local rotcf = CFrame.new(math.random()*smalldist-(smalldist/2),math.random()*smalldist-(smalldist/4),math.random()*smalldist-(smalldist/2)) * CFrame.Angles(math.random()*tau,math.random()*tau,math.random()*tau)
			local longboi = game.ServerStorage.wabbajack_misc.sparksmall:clone()
			longboi.Parent = lightning
			longboi.animate.Disabled = false
			longboi.CFrame = cf:ToWorldSpace(rotcf)
		end
		local size = UDim2.new(15,0,15,0)
		local impact1 = game.ServerStorage.wabbajack_misc.sparksmall:clone()
		impact1.Parent = lightning
		impact1.animate.Disabled = false
		impact1.CFrame = cf:ToWorldSpace(CFrame.new(0,5,0)*CFrame.Angles(0,0,math.pi/2))
		impact1.top.f.Size = size
		impact1.bottom.f.Size = size
		local impact2 = game.ServerStorage.wabbajack_misc.sparksmall:clone()
		impact2.Parent = lightning
		impact2.animate.Disabled = false
		impact2.CFrame = cf:ToWorldSpace(CFrame.new(0,5,0)*CFrame.Angles(math.pi/2,0,0))
		impact2.top.f.Size = size
		impact2.bottom.f.Size = size
		debris:AddItem(lightning,10)
		wait(0.5)
		lightning.Beam.Enabled = false
		wait(math.random(3,7))
		lightning:remove()
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
