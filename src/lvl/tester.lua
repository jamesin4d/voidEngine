--test
-- i have no motherfucking idea what i'm doing here.
-- like seriously, how the shit do you make a game.
local nextLevel = 'numbtwo'
local levGen = require "src.levelGen"

local world = makeWorld(16)
local lvl = levGen.level(world)
player = newPlayable(world,50,50,12,12)
local items = world:getEntities()

function love.update(dt)
	local items = world:getEntities()
	if love.keyboard.isDown("n") then mem:emit('toLevel',nextLevel) end
	inputSystem(items,dt)
	moveSystem(items)
	removeWithClick(items)
	camera.lookAt(player.rect.x,player.rect.y)
end

function love.draw()
	local items = world:getEntities()
	camera.draw(
	function()
		drawSystem(items)
		love.graphics.print(love.timer.getFPS(),40,40)
		--love.graphics.print(tostring(player.collider.colliding),40,52)
	end)
	love.graphics.setBackgroundColor(60, 60, 60)

end
