local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)
local debris = game:GetService("Debris")
local damage = 75
local tau = 2*math.pi
local bigdist = 15
local smalldist = 15
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
		local lightning = game.ServerStorage.wabbajack_misc.frostrune:clone()
		lightning.Parent = workspace
		lightning.CFrame = cf
		local bois = {}
		for i = 1, math.random(5,20) do
			local rotcf = CFrame.new(math.random()*bigdist-(bigdist/2),math.random()*bigdist-(bigdist/4),math.random()*bigdist-(bigdist/2)) * CFrame.Angles(math.random()*tau,math.random()*tau,math.random()*tau)
			local longboi = game.ServerStorage.wabbajack_misc.icekrystal:clone()
			longboi.Parent = lightning
			longboi.animate.Disabled = false
			longboi.CFrame = cf:ToWorldSpace(rotcf)
			longboi.top.Enabled = false
			longboi.bottom.Enabled = false
			table.insert(bois,longboi)
		end
		for i = 1, math.random(5,20) do
			local rotcf = CFrame.new(math.random()*smalldist-(smalldist/2),math.random()*smalldist-(smalldist/4),math.random()*smalldist-(smalldist/2)) * CFrame.Angles(math.random()*tau,math.random()*tau,math.random()*tau)
			local longboi = game.ServerStorage.wabbajack_misc.icewisps:clone()
			longboi.Parent = lightning
			longboi.animate.Disabled = false
			longboi.CFrame = cf:ToWorldSpace(rotcf)
			longboi.top.Enabled = false
			longboi.bottom.Enabled = false
			table.insert(bois,longboi)
		end
		local size = UDim2.new(15,0,15,0)
		local impact1 = game.ServerStorage.wabbajack_misc.smoke:clone()
		impact1.Parent = lightning
		impact1.animate.Disabled = false
		impact1.CFrame = cf:ToWorldSpace(CFrame.new(0,5,0)*CFrame.Angles(0,0,math.pi/2))
		impact1.top.f.Size = size
		impact1.bottom.f.Size = size
		impact1.top.Enabled = false
		impact1.bottom.Enabled = false
		table.insert(bois,impact1)
		local impact2 = game.ServerStorage.wabbajack_misc.smoke:clone()
		impact2.Parent = lightning
		impact2.animate.Disabled = false
		impact2.CFrame = cf:ToWorldSpace(CFrame.new(0,5,0)*CFrame.Angles(math.pi/2,0,0))
		impact2.top.f.Size = size
		impact2.bottom.f.Size = size
		impact2.top.Enabled = false
		impact2.bottom.Enabled = false
		table.insert(bois,impact2)
		lightning.impact:Play()
		local debounce = false
		local function subhitfunc(hit)
			if debounce then return end
			local human = lib.findInAncestry(hit,{"Humanoid"})
			if not human then return end
			debounce = true
			lightning.top.Enabled = false
			lightning.bottom.Enabled = false
			lightning.explosion:Play()
			human.Health = human.Health - damage
			for k,v in pairs(bois) do
				v.top.Enabled = true
				v.bottom.Enabled = true
			end
			debris:AddItem(lightning,10)
			local timer = 0
			while timer < 5 do
				local tr = lib.lerp(0,1,timer,0,5)
				timer = timer + wait()
				for k,v in pairs(bois) do 
					v.top.f.i.ImageTransparency = tr
					v.bottom.f.i.ImageTransparency = tr
				end
			end
			wait()
			lightning:remove()
		end
		
		lightning.Touched:connect(subhitfunc)
		debris:AddItem(lightning,120)
		wait(120)
		lightning:remove()
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
