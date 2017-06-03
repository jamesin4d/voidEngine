-- i've written this function several different ways and still it refuses
-- to work. which is irritating as fuck since it should be simple
-- update: this is what it wanted typed
local lifetimeCounter = encos.createSystem(
  {"lived","lifetime"},
  function(item,lived,lifetime)
    if item.lived >= lifetime then mem:emit("entityDestroy",item)
    else item.lived = item.lived + 0.2
    end
  end)
return lifetimeCounter
