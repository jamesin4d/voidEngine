-- encos.lua
-- entity, component, system; a minimal entity/component/system framework
local unpack = table.unpack or _G.unpack
local function addComponent(e,c,i) -- entity, component, instance
	e[c] = setmetatable(i or {},{__index = c})
	return e
end

local function getComponentsTable(e,cs)
	local values = {}
	for i, c in ipairs(cs) do
		local v = e[c]
		if not v then return end
		table.insert(values,v)
	end
	return values
end

local function getComponents(...) return unpack(getComponentsTable(...) or {}) end

local protoEntity = {
	addComponent = addComponent,
	getComponents = getComponents,
	getComponentsTable = getComponentsTable
}

local function createEntity(e) return setmetatable(e or {},{__index = protoEntity}) end

-- local bitchingSystem = createSystem({},function()end)
local function createSystem(cs, process)
  local function handle(e)
    local values = getComponentsTable(e, cs)
    if values then
				process(e, unpack(values))
			end
		end
  return function(es)
    for i, e in ipairs(es) do
      handle(e)
    end
  end
end
-- 	each function example usage --
--for item, vel in ecs.each(entities, { 'velocity', 'monster' }) do
local function each(es, cs)
  local i = 0
  return function()
    while true do
      i = i + 1
      local e = es[i]
      if not e then return end
      local values = getComponentsTable(e, cs or {})
      if values then return e, unpack(values) end
    end
  end
end
-- skunk the blunderbuss to numb the
return { -- public interface
  createEntity = createEntity,-- exceed the threshold for complexities mental figure eights
  createSystem = createSystem,
  each = each,
}
