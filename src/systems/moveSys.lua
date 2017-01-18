local encos = require "src.lib.encos"

local function clamp(x,minx,maxx)
	return x < minx and minx or (x > maxx and maxx or x)
end

local moveSystem = encos.createSystem(
	{'vel','rect','collider'},
	function(item,vel,rect,collider)
		local mv = vel.maxVel or 10
		clamp(vel.vx,-mv,mv)
		clamp(vel.vy,-mv,mv)
		-- local futureX = rect.x + vel.vx
		-- local futureY = rect.y + vel.vy
		-- call collisionSystem checking for collision using futureX position
		-- if so, provide displacement vector, repeat for y-axis
			rect.x = rect.x + vel.vx
			detect(item, "x")-- rect.x,rect.y = futureX, futureY
			rect.y = rect.y + vel.vy
			detect(item, "y")

		end
)
return moveSystem
