--micro event manager
local mem = {}
mem.__index = mem

function mem:new()
  local _manager = {}
  setmetatable(_manager, mem)

  _manager.handlers = {}

  return _manager
end

-------------------------------------
function mem:eventExists(eventname)
  return self.handlers[eventname] and true or false
end

function mem:getHandlers(eventname)
  return self.handlers[eventname]
end

function mem:initHandlers(eventname)
  self.handlers[eventname] = {}
end
-----------------------------------------------
function mem:registerHandler(eventname, callback)
  table.insert(self.handlers[eventname], callback)
end
function mem:on(eventname, callback)
  if not self:eventExists(eventname) then self:initHandlers(eventname) end
  self:registerHandler(eventname, callback)
  return self
end

function mem:emit(eventname, params)
  if not self:eventExists(eventname) then return self end
  for k, v in pairs(self:getHandlers(eventname)) do --v = callback
    v(params)
  end
  return self
end

function mem:remove(eventname, callback)
  if not self:eventExists(eventname) then return self end
  local callbackString = string.dump(callback)
  for k, v in pairs(self:getHandlers(eventname)) do
    if string.dump(v) == callbackString then
      self.handlers[eventname][k] = nil
    end
  end
  return self
end

function mem:reset(eventname)
  if not self:eventExists(eventname) then return self end
  self:initHandlers(eventname)
  return self
end

function mem:getListenerCount(eventname)
  return (self:eventExists(eventname) and #self:getHandlers(eventname) or -1)
end
-- aliases
function mem:addListener(...) return self:on(...) end
function mem:removeListener(...) return self:remove(...) end
function mem:removeListeners(...) return self:reset(...) end

return mem