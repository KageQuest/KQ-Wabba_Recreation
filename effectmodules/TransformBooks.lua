local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

local function findInAncestry2(obj,class,root) --searches names in list searchForNames, returns obj found or nil
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
	local player = game.Players:GetPlayerFromCharacter(char)
	local hrpcf = char.HumanoidRootPart.CFrame
	char.Parent = game.Lighting
	local morphs = {}
	local amount = math.random(3,15)
	for i=1,amount do
		local morph = game.ServerStorage.wabbajack_misc.Tool_Book:Clone()
		local colour = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
		for k,v in pairs(morph.Cover:GetChildren()) do
			v.Color = colour
		end
		morph.Handle.CFrame = hrpcf+Vector3.new(math.random(-10,10),0,math.random(-10,10))
		morph.Parent = workspace
		table.insert(morphs,morph)
	end
	local morph = morphs[math.random(1,#morphs)]
	morph.Handle.CFrame = char.HumanoidRootPart.CFrame:toWorldSpace(CFrame.new(0,-1.7,0) * CFrame.Angles(0,math.pi,0))
	local cam = script.cam:Clone()
	cam.Parent = player.PlayerGui
	cam.cam.setcam.Value = morph.Handle
	cam.cam.Disabled = false
	coroutine.wrap(function()
		local resetflag = false
		cam.cam.RemoteEvent.OnServerEvent:connect(function(plyr)
			print("called")
			print(player == plyr)
			if player == plyr then resetflag = true end
			end)
		while morph.Parent and not resetflag do
			wait()
		end
		player:LoadCharacter()
	end)()
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
