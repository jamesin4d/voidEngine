local colorComp = require "src.components.colorComponent"
local rectComp = require "src.components.rectComponent"

local function newBlock(world,x,y,w,h)
  local block = {
    world = world,
    rect = rectComp(x,y,w,h),
    color = colorComp(180,180,180)
  }
  encos.createEntity(block)
  mem:emit("entityCreate",block)
  return block
end
return newBlock
