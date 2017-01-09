local encos = require "src.lib.encos"
local drawSystem = encos.createSystem(
	{'rect','color'},
	function(item,rect,color)
		local r,g,b = color.r,color.g,color.b
		local l,t,w,h = rect.x,rect.y,rect.width,rect.height
		love.graphics.setColor(r,g,b)
		love.graphics.rectangle('fill',l,t,w,h)
		love.graphics.reset()
	end
)
return drawSystem
