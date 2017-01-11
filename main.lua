-- main

require "src.lovedebug"

local function kill()
	love.event.quit()
end
function love.load()
	require "src.required"
	mem = microem:new()
	mem:on('quit',kill)
	mem:on('changeState',function(s) state.switch('src.'..s) end)
	mem:on('toLevel',function(l) state.switch('src.lvl.'..l) end)
-- for ease of use, this function makes assumptions
	mem:on('entityCreate',
		function(e)
			e.world:add(e)
			e.creationTime = love.timer.getTime()
		end)
	mem:on('entityDestroy',function(e) e.world:remove(e) end)
	mem:emit('toLevel','tester')
end
