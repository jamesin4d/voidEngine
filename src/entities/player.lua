local colorComp = require "src.components.colorComponent"
local velocityComp = require "src.components.velocityComponent"
local rectComp = require "src.components.rectComponent"
local colliderComp = require "src.components.collisionType"

local function newPlayable(x,y,w,h)
  --body...
  local player = {
    vel = velocityComp(),
    rect = rectComp(x,y,w,h),
    control = true,
    color = colorComp(130,130,80),
    collider = colliderComp("kinetic")
 }
 encos.createEntity(player)
  return player
end
return newPlayable
