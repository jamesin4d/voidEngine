local encos = require "src.lib.encos"

local function clamp(x,minx,maxx)
	return x < minx and minx or (x > maxx and maxx or x)
end

local moveSystem = encos.createSystem(
	{'vel','rect'},
	function(item,vel,rect)
		local mv = vel.maxVel or 100
		clamp(vel.vx,-mv,mv)
		clamp(vel.vy,-mv,mv)
		-- local futureX = rect.x + vel.vx
		-- local futureY = rect.y + vel.vy
		-- call collisionSystem checking for collision using futureX position
		-- if so, provide displacement vector, repeat for y-axis
		detect(item)
		rect.x = rect.x + vel.vx -- rect.x,rect.y = futureX, futureY
		rect.y = rect.y + vel.vy
	end
)
return moveSystem
