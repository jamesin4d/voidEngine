local rect = class:extend()
function rect:init(x,y,w,h)
  self.x, self.y = x or 0, y or 0
  self.width = w
  self.height = h
end

function rect:getRect()
  return self.x,self.y,self.width,self.height
end

function rect:left() return self.x end
function rect:right() return self.x+self.width-1 end
function rect:top() return self.y end
function rect:bottom() return self.y+self.height-1 end

function rect:center() return self.x+self.width/2, self.y+self.height/2 end

return rect
