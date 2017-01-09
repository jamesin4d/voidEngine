--test
local prevLevel = 'tester'
local tld = require "lvl.test"

items = {}
player = newPlayable(150,150,12,12)
table.insert(items,player)

function love.update(dt)
	if love.keyboard.isDown('b') then mem:emit('toLevel',prevLevel) end
	inputSystem(items,dt)
	moveSystem(items)
	camera.lookAt(player.rect.x,player.rect.y)
end

function love.draw()
	camera.draw(
	function()
		drawSystem(items)
	end)
end
