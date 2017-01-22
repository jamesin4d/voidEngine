-- this is just a temporary script to be able to click on an entity in game and remove it from the world
local rectFunc = require "src.physics.rectFunctions"

local removeWithClick = encos.createSystem(
  {"rect","world"},
  function(item,rect,world)
    if love.mouse.isDown(1) and rectFunc.containsPoint(rect.x,rect.y,rect.width,rect.height,love.mouse.getPosition()) then world:remove(item) end
   end
)
return removeWithClick
