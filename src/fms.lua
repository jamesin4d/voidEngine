state = {}
passed = {}

function state.switch(state)
  passed = {}
  local matches= {}

  for m in string.gmatch(state, "[^;]+") do
    matches[#matches+1] = m
  end
  state = matches[1]
  matches[1] = nil
  if (matches[2]~=nil) then
    for i, m in pairs(matches) do
      passed[#passed+1] = m
    end
  end
  package.loaded[state] = false
  require(state)
end

function state.clear()
  passed = nil
end

return state
