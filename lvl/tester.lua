--test
-- i have no motherfucking idea what i'm doing here.
-- like seriously, how the shit do you make a game.
local nextLevel = 'numbtwo'
local levGen = require "src.levelGen"
local lvl = levGen(100,16)
items = {}
playable = {}
player = newPlayable(50,50,12,12)
table.insert(playable,player)
for k,v in ipairs(lvl) do
	table.insert(items, v)
end

function love.update(dt)
	if love.keyboard.isDown("n") then mem:emit('toLevel',nextLevel) end
	inputSystem(playable,dt)
	moveSystem(playable)
	camera.lookAt(player.rect.x,player.rect.y)
end

function love.draw()
	camera.draw(
	function()
		--camera.lookAt(player.rect.x,player.rect.y)
		drawSystem(items)
		drawSystem(playable)
	end)
	--drawSystem(items)
end
