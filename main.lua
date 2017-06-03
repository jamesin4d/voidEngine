-- main
-- we must go spread our moon technologies
-- i feel like this is a cleaner approach to this.
-- theres a bit more clutter here and in the /src/ directory but coherency!
require "lovedebug"

function love.load()
	class = require "src.soil"
	microem = require "src.microem"
	encos = require "src.encos"
	moveSystem = require "src.moveSys"
	drawSystem = require "src.drawSys"
	colorComp = require "src.components.colorComponent"
	velocityComp = require "src.components.velocityComponent"
	rectComp = require "src.components.rectComponent"
	colliderComp = require "src.components.collisionFlag"
	cam = require "src.cam"
	camera = require "src.camera"
	inputSystem = require "src.inputsys"
	state = require "src.fms"
	makeWorld = require "src.world"
	newPlayable = require "src.entities.player"
	newDebris = require "src.entities.debris"
	lifetimeCounter = require "src.lifetimeCounter"
	trailDebris = require "src.trailDebris"

	mem = microem:new()
	mem:on('quit',function()love.event.quit()end)
	mem:on('changeState',function(s) state.switch('src.'..s) end)
	mem:on('toLevel',function(l) state.switch('src.lvl.'..l) end)
-- for ease of use, this function makes assumptions
	mem:on('entityCreate',
		function(e)
			e.world:add(e) -- notably that the entity passed has a world associated
			e.creationTime = love.timer.getTime()
		end)
	mem:on('entityDestroy',function(e) e.world:remove(e) end)
	mem:emit('toLevel','tester')
end
