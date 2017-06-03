-- rect 3.0 bitchass, incorperating my minimal ecs library. making progress
local MOE = 1e-10 -- this is the floating point margin of error
local abs = math.abs

-- private functions
local function nearest(x,a,b)
	if abs(a-x) < abs(b-x) then return a else return b end
end

local function nearestCorner(x,y,w,h,px,py)
	return nearest(px,x,x+w), nearest(py,y,y+h)
end

local function minkowskyDifference(one,other)
  local r1 = one:getComponents({"rect"})
  local x1,y1,w1,h1 = r1.x,r1.y,r1.width,r1.height
  local r2 = other:getComponents({"rect"})
  local x2,y2,w2,h2 = r2.x,r2.y,r2.width,r2.height
	return x2-x1-w1, y2-y1-h1, w1+w2, h1+h2
end

local function containsPoint(x,y,w,h,px,py)
	return px-x>MOE and py-y>MOE and x+w-px>MOE and y+ h - py > MOE
end

local function isIntersecting(one,other)
  local r1 = one:getComponents({"rect"})
  local x1,y1,w1,h1 = r1.x,r1.y,r1.width,r1.height
  local r2 = other:getComponents({"rect"})
  local x2,y2,w2,h2 = r2.x,r2.y,r2.width,r2.height
	return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

local function rectsIntersect(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

local function getSquareDistance(one,other)
  local r1 = one:getComponents({"rect"})
  local x1,y1,w1,h1 = r1.x,r1.y,r1.width,r1.height
  local r2 = other:getComponents({"rect"})
  local x2,y2,w2,h2 = r2.x,r2.y,r2.width,r2.height
  local dx = x1 - x2 + (w1 - w2)/2
  local dy = y1 - y2 + (h1 - h2)/2
  return dx*dx + dy*dy
end

return {
	rectsIntersect = rectsIntersect,
	isIntersecting = isIntersecting,
	getSquareDistance = getSquareDistance,
	minkowskyDifference = minkowskyDifference,
	nearestCorner = nearestCorner,
	containsPoint = containsPoint
}
