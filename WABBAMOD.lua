--This is a "Module Script" inside of the tools "Handle" part.
--It cannot run on its own, and instead is run/instantiated when called by another script. 
--In this case, it is called on Line 5 in "Wabbajack_Server".

--Create the module, which is simply a table that can be populated
local module = {}
local lib = require(script.Parent.aaadddLib)  --Library file, kindly provided by a friend known as "aaaddd" on Roblox. It is unavailable for redistribution, but some of its functions are required so I will be leaving its references in this script.
local debris = game:GetService("Debris") --A high-level service provided by Roblox; This essentially acts as garbage collection. We can tell this service to "collect" objects after a period of time to be properly deleted from memory to prevent lag or other unforeseen issues
local handle = script.Parent

--This adds a new entry to the module called "Effect". This is the physical "fireball" sprite that is created and fired from the tool.
module.effect = function(tex)
	local i = 0
	local umax = 2
	local vmax = 2
	while true do
		wait(1.5/24)
		local u = lib.looprange(0,i,umax)
		local v = math.floor(lib.looprange(0,i/umax,vmax))
		i = i +1
		i = lib.looprange(0,i,umax*vmax)
		if not tex then return end
		local pos = UDim2.new(-u,0,-v,0)
		tex.Position = pos
	end
end

--This function is only usable by the module.
--Its a search function that looks in the ancestry for an object of the matching name, and returns the object or nil if it doesnt find anything.
local function findInAncestry2(obj,class,root)
	if not root then root = workspace end
	local cd = obj.Parent
	local result = nil
	while cd ~= root.Parent do
			result = cd:IsA(class)
			if result then return result end --Return result if found
		cd = cd.Parent--try parent dir
	end
	return nil --Nothing found
end

--This function removes a "morph" from a player or humanoid object. 
--In Roblox, a "morph" is when a player is transformed into a different model, or has additional models/parts applied to them.
local function unmorph(part,fireball,hitfunc)
	local humanoid = lib.findInAncestry(part,{"Humanoid"})
	if not humanoid then hitfunc(part,fireball) return end
	local refptr = humanoid.Parent:FindFirstChild("sheo_morph")
	if not refptr then hitfunc(part,fireball) return end
	local parts = lib.allChildsMatching(humanoid.Parent, function(a) return (a:IsA("BasePart") and a.Name ~= "HumanoidRootPart" and a.Name ~= "effect"  and (not findInAncestry2(a,"Tool",humanoid.Parent)) ) or (a:IsA("Decal") and a.Name == "face") end)
	for k,v in pairs(parts) do v.Transparency = 0 end
	refptr.Value:remove()
	refptr:remove()
	fireball:remove()
end

--This function adds a new function to the module, which controls the "fire ball" effect that is launched from the tool.
module.fire = function(mousehit,hitfunc)	
	local fireball = Instance.new("Part",workspace) --The projectile brick
	fireball.Shape = Enum.PartType.Ball
	fireball.Size = Vector3.new(2,2,2)
	fireball.CFrame = handle.CFrame:ToWorldSpace(CFrame.new(0,5,0))
	fireball.CanCollide = false
	fireball.Transparency = 1
	
	local eff = script.Parent.Parent.effect.BillboardGui:Clone() --Visual effect
	eff.Parent = fireball
	eff.Enabled = true
	eff.Size = UDim2.new(3,0,3,0)
	coroutine.wrap(module.effect)(eff.Frame.ImageLabel)	
	
	local vel = Instance.new("BodyVelocity",fireball) --Body velocity to propel the projectile
	vel.MaxForce = Vector3.new(1,1,1)*1e16
	vel.Velocity = (mousehit.p - fireball.Position).Unit * 200
	fireball.Velocity = vel.Velocity
	
	
	fireball.Touched:Connect( function(part) unmorph(part,fireball,hitfunc) end) --programmable hit function
	debris:AddItem(fireball,20) --Flag the projectile to be destroyed by garbage collection in 20 seconds if it does not hit anything
end


--Returns the module to the parent script that called it, with all the newly created functions and variables.
return module
