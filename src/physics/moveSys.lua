local function clamp(x,minx,maxx)
	return x < minx and minx or (x > maxx and maxx or x)
end

local moveSystem = encos.createSystem(
	{'vel','rect','collider','world'},
	function(item,vel,rect,collider,world)
		local mv = vel.maxVel or 10
		clamp(vel.vx,-mv,mv)
		clamp(vel.vy,-mv,mv)
		rect.x = rect.x + vel.vx -- move along x-axis
		detect(item, "x") -- check for collisions on x
		rect.y = rect.y + vel.vy -- rinse
		detect(item, "y") -- repeat.
		world:update(item)
		end
)
return moveSystem
