local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

local damage = 20

local function findInAncestry2(obj,class,root)--searches names in list searchForNames, returns obj found or nil
	if not root then root = workspace end
	local cd = obj.Parent
	local result = nil
	while cd ~= root.Parent do
			result = cd:IsA(class)
			if result then return result end--return result if found
		cd = cd.Parent--try parent dir
	end
	return nil --nothing found
end

local function morph(char)
	local parts = lib.allChildsMatching(char, function(a) return a:IsA("BasePart") and not findInAncestry2(a,"Tool",char) end)
	for k,v in pairs(parts) do
		v.Transparency = 1
		if v.Name == "Head" then
			v.face.Transparency = 1
		end
	end
	local morph = game.ServerStorage.wabbajack_misc.Chicken:Clone()
	morph.CFrame = char.HumanoidRootPart.CFrame:toWorldSpace(CFrame.new(0,-1.7,0) * CFrame.Angles(0,math.pi,0))
	morph.Parent = char.HumanoidRootPart
	lib.weld(char.Head,morph)
	wait(20)		
	local boom = Instance.new("Explosion",morph)
	boom.ExplosionType = Enum.ExplosionType.NoCraters
	boom.BlastRadius = 1
	boom.BlastPressure = 0
	boom.Position = morph.CFrame.p
	char.Humanoid.Health = 0
end

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		morph(humanoid.Parent)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
