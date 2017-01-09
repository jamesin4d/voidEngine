--inputSystem(items,dt)
-- this is implemented here to make easy use of dt
local function inputSystem(items, dt)
  for item, vel in encos.each(items,{'vel','control'}) do
    local kb = love.keyboard.isDown
    if kb('escape') then
  		mem:emit('quit')
  	end

    if kb('w') then vel.vy = vel.vy - dt*(vel.vy>0 and vel.decel or vel.accel)
    elseif kb('s') then vel.vy = vel.vy + dt*(vel.vy<0 and vel.decel or vel.accel)
    else
      local brake = dt*(vel.vy < 0 and vel.decel or -vel.decel)
      if math.abs(brake) > math.abs(vel.vy) then vel.vy = 0
      else vel.vy = vel.vy + brake end
    end
    --  left and right
    if kb('a') then vel.vx = vel.vx - dt*(vel.vx > 0 and vel.decel or vel.accel)
    elseif kb('d') then vel.vx = vel.vx + dt*(vel.vx < 0 and vel.decel or vel.accel)
    else
      local brake = dt*(vel.vx < 0 and vel.decel or -vel.decel)
      if math.abs(brake) > math.abs(vel.vx) then vel.vx = 0
      else vel.vx = vel.vx + brake end
    end
  end
end
return inputSystem
