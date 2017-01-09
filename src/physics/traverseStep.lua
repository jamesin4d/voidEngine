local function gridTraverseInitStep(cellsize, ct, t1,t2)
  local v = t2-t1
  if v > 0 then
    return 1, cellsize/v, ((ct+v)*cellsize-t1)/v
  elseif v < 0 then
    return -1, -cellsize/v, ((ct+v-1)*cellsize-t1)/v
  else
    return 0, math.huge,math.huge
  end
end
return gridTraverseInitStep
