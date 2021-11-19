local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

local damage = 80

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
		local humanoid = lib.findInAncestry(part,{"Humanoid"})
		if not humanoid then return end
		local player = game.Players:GetPlayerFromCharacter(humanoid.Parent)
		if not player then return end
		pcall(function()
			local stamina = player.skyHealth.stamina
			stamina.Value = lib.hardrange(0,stamina.Value - damage, stamina.max.Value)
		end)
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
