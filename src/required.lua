-- populates the global table of needed requires
do
class = require "src.lib.soil"
microem = require "src.lib.microem"
encos = require "src.lib.encos"

moveSystem = require "src.systems.moveSys"
drawSystem = require "src.systems.drawSys"
collisionSystem = require "src.systems.collisionSys"

colorComp = require "src.components.colorComponent"
velocityComp = require "src.components.velocityComponent"
rectComp = require "src.components.rectComponent"
colliderComp = require "src.components.collisionFlag"

cam = require "src.lib.cam"
camera = require "src.lib.camera"
inputSystem = require "src.systems.inputsys"
state = require "src.lib.fms"
makeWorld = require "src.physics.world"
newPlayable = require "src.entities.player"
end
