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
	mem:emit('toLevel','tester')
end
