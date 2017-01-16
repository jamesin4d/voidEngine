--test
-- i have no motherfucking idea what i'm doing here.
-- like seriously, how the shit do you make a game.
local nextLevel = 'numbtwo'
local levGen = require "src.levelGen"

local world = makeWorld(16)
local lvl = levGen.level(world)
items = {}
for _,v in pairs(lvl) do table.insert(items,v) end
player = newPlayable(world,50,50,12,12)
table.insert(items,player)


function love.update(dt)
	if love.keyboard.isDown("n") then mem:emit('toLevel',nextLevel) end
	inputSystem(items,dt)
	moveSystem(items)
	--detect(player)
	camera.lookAt(player.rect.x,player.rect.y)
end

function love.draw()
	camera.draw(
	function()
		--camera.lookAt(player.rect.x,player.rect.y)
		drawSystem(items)
	end)
	--drawSystem(items)
end
