local encos = require "src.encos"
local drawSystem = encos.createSystem(
	{'rect','color'},
	function(item,rect,color)
		local r,g,b = color.r,color.g,color.b
		local lr,lg,lb = r-80,g-80,b-80
		local l,t,w,h = rect.x,rect.y,rect.width,rect.height
		love.graphics.setColor(r,g,b)
		love.graphics.rectangle('fill',l,t,w,h)
		love.graphics.setColor(lr, lg, lb)
		love.graphics.rectangle('line', l, t, w, h)
		love.graphics.reset()

	end
)
return drawSystem
