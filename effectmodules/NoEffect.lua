local module = {}
local wabbamod = require(script.Parent.Parent.WABBAMOD)
local lib = require(script.Parent.Parent.aaadddLib)

module.fire = function(moushit,handle)
	
	local function hitfunc(part,proj)
		if part.CanCollide then proj:remove() else return end
	--It does nothing :)
	--https://www.youtube.com/watch?v=dQw4w9WgXcQ
	end
	
	wabbamod.fire(moushit,hitfunc)
end

return module
