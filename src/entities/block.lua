local colorComp = require "src.components.colorComponent"
local rectComp = require "src.components.rectComponent"

local function newBlock(x,y,w,h)
  local block = {
    rect = rectComp(x,y,w,h),
    color = colorComp(180,180,180)
  }
  encos.createEntity(block)
  return block 
end
return newBlock
