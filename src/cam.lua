-- camera redub
local camera = {
  x = 0,
  y = 0,
  scalex = 1,
  scaley = 1,
  rotation = 0
}

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1/self.scalex,1/self.scaley)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(x,y)
  self.x = self.x + (x or 0)
  self.y = self.y + (y or 0)
end

function camera:setScale(sx,sy)
  local sx = sx or 1
  self.scalex = self.scalex*sx
  self.scaley = self.scaley*(sy or sx)
end

function camera:rotate(r)
  self.rotation = self.rotation + r
end

function camera:position(x,y)
  self.x = x or self.x
  self.y = y or self.y
end

return
