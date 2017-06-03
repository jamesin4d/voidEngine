--test
-- i have no motherfucking idea what i'm doing here.
-- like seriously, how the shit do you make a game.
local levGen = require "src.levelGen"

world = makeWorld(16)
local lvl = levGen.level(world)
player = newPlayable(world,50,50,12,12)
items = world:getEntities()

function love.update(dt)
	lifetimeCounter(items)
	inputSystem(items,dt)
	moveSystem(items)
	trailDebris(items)
	--camera.lookAt(player.rect.x,player.rect.y)
end

function love.draw()
	camera.draw(
	function()
		drawSystem(items)
		love.graphics.print(love.timer.getFPS(),40,40)
	end)
	love.graphics.setBackgroundColor(60, 60, 60)

end
