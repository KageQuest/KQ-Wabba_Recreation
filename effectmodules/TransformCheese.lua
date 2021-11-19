local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

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
	local player = game.Players:GetPlayerFromCharacter(char)
	char.Parent = game.Lighting
	local morph = game.ServerStorage.wabbajack_misc.Food_CheeseWheel:Clone()
	morph.Handle.CFrame = char.HumanoidRootPart.CFrame:toWorldSpace(CFrame.new(0,-1.7,0) * CFrame.Angles(0,math.pi,0))
	morph.Handle.Anchored = false
	morph.Parent = workspace
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
