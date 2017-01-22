-- simple oop implemented lightly; soil.lua
local Class = {}
Class.__index = Class
function Class:init() end
function Class:extend(name)
  local object = {}
  for k,v in pairs(self) do if k:find("__") == 1 then object[k] = v end end
  object.__index = object
  object.super = self
  object.name = name
  setmetatable(object, self)
  return object
end
function Class:is(t)
  local mt = getmetatable(self)
  while mt do
    if mt == t then return true end
    mt = getmetatable(mt)
  end
  return false
end
function Class:__call(...)
  local o = setmetatable({},self)
  o:init(...)
  return o
end
return Class
