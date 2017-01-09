-- rect 2.0
local object = require "src.object"
local MOE = 1e-10 -- this is the floating point margin of error
local abs = math.abs

-- private functions
local function nearest(x,a,b)
	if abs(a-x) < abs(b-x) then return a else return b end
end

local function nearestCorner(x,y,w,h,px,py)
	return nearest(px,x,x+w), nearest(py,y,y+h)
end

local function minkowskyDifference(self,rect2)
	local x1,y1,w1,h1 = self:getRect()
	local x2,y2,w2,h2 = rect2:getRect()
	return x2-x1-w1, y2-y1-h1, w1+w2, h1+h2
end

local function containsPoint(x,y,w,h,px,py)
	return px-x>MOE and py-y>MOE and x+w-px>MOE and y+ h - py > MOE
end

local function isIntersecting(self,other)
	local x1,y1,w1,h1 = self:getRect()
	local x2,y2,w2,h2 = other:getRect()
	return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

local function getSquareDistance(self,other)
	local x1,y1,w1,h1 = self:getRect()
	local x2,y2,w2,h2 = other:getRect()
  local dx = x1 - x2 + (w1 - w2)/2
  local dy = y1 - y2 + (h1 - h2)/2
  return dx*dx + dy*dy
end

------------------
-- Public interface
------------------
local rect = object:extend()
rect.getSquareDistance = getSquareDistance
rect.minkowskyDifference = minkowskyDifference
rect.nearestCorner = nearestCorner

function rect:new(x,y,w,h)
	local defaultSize = 16
	self.x = x or 0
	self.y = y or 0
	self.width = w or defaultSize
	self.height = h or defaultSize
	self:updateSides()
	return self
end

function rect:updateSides()
	self.top = self.y
	self.bottom = self.y + self.height
	self.left = self.x
	self.right = self.x + self.width
end

function rect:setDimensions(w,h)
	self.width = w or self.width
	self.height = h or self.height
	self:updateSides()
end

function rect:setPosition(x,y)
	self.x, self.y = x,y
	self:updateSides()
end

function rect:getPosition()
	return self.x,self.y
end

function rect:getRect()
	return self.x,self.y,self.width,self.height
end

function rect:getLeft() return self.x end

function rect:getTop() return self.y end

function rect:getRight() return self.x+self.width-1 end

function rect:getBottom() return self.y+self.height-1 end

function rect:getCenter()
	return self.x + self.width/2, self.y + self.height/2
end

function rect:moveHorizontal(dx)
	self.x = self.x + dx
	self:updateSides()
end

function rect:moveVertical(dy)
	self.y = self.y + dy
	self:updateSides()
end

function rect:collides(other)
	return isIntersecting(self,other)
end

return rect
