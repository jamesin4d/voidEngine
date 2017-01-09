local manager = class:extend("manager")

function manager:init(args)
  -- body...
  self.camera = camera
  self.players = {}
  self.bullets = {}
  self.items = {}

end

function manager:update(dt)
  inputSystem(self.players,dt)
  moveSystem(self.players)
end

function manager:draw()

  self.camera.draw(
  function()
    drawSystem(self.items)
    drawSystem(self.players)
    drawSystem(self.bullets)
  end)

end

return manager
