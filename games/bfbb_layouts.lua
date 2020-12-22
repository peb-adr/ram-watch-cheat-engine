package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.layouts = nil
local layoutsModule = require 'layouts'
local Layout = layoutsModule.Layout
-- local CompoundElement = layoutsModule.CompoundElement
-- local SimpleElement = layoutsModule.SimpleElement

package.loaded.inputDisplayModule = nil
local inputDisplayModule = require 'inputdisplay'
local InputDisplay = inputDisplayModule.InputDisplay

local layouts = {}

layouts.test = subclass(Layout)
function layouts.test:init()
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  self.window:setSize(400, 700)

  local game = self.game
  
  self:addLabel{x=10, y=10, fontSize=16}
  self:addItem("Collectables")
  self:addLabel{x=20, y=40, fontSize=12}
  self:addItem(game.spatulas)
  self:addItem(game.shinyObjects)
  self:addItem(game.socks)

  self:addLabel{x=10, y=110, fontSize=16}
  self:addItem("Position")
  self:addLabel{x=20, y=140, fontSize=12}
  self:addItem(game.xpos)
  self:addItem(game.ypos)
  self:addItem(game.zpos)

  self:addLabel{x=10, y=210, fontSize=16}
  self:addItem("Momentum")
  self:addLabel{x=155, y=275, fontSize=12}
  -- self:addItem(game.xvel)
  -- self:addItem(game.yvel)
  -- self:addItem(game.zvel)
  self:addItem(game.hvelLength)
  self:addItem(game.vvelLength)

  self:addLabel{x=10, y=360, fontSize=16}
  self:addItem("Bowling")
  self:addLabel{x=20, y=390, fontSize=12}
  self:addItem(game.bowlingState)
  self:addItem(game.bowlingSpeed)
  self:addItem(game.bowlingDamp)

  self:addLabel{x=10, y=460, fontSize=16}
  self:addItem("Misc")
  self:addLabel{x=20, y=490, fontSize=12}
  self:addItem(game.health)
  self:addItem(game.facingAngle)
  -- self:addItem(game.camAngle)
  -- self:addItem(game.hansState)
  self:addItem(game.hansStateStr)
  -- self:addItem(game.buttonPressed)
  -- self:addItem(game.buttonReleased)

  self:addLabel{foregroundColor=0x000000}
  -- Momentum Vectors: to adjust scaling change max - vector will scale in range(0, max)
  self:addImage(self.game.HVelocityImage, {game}, {max=15, lineThickness=2, foregroundColor=0x000000, x=20, y=250})
  self:addImage(self.game.VVelocityImage, {game}, {max=15, lineThickness=2, foregroundColor=0x000000, x=125, y=250})
  
  self:addImage(InputDisplay,
      {"TronStyleNoDpad",
        self.game.buttonBits,
        self.game.stickX,
        self.game.stickY,
        self.game.xCStick,
        self.game.yCStick,
        self.game.lShoulder,
        self.game.rShoulder
      },
      {x=10, y=580})
end

return {
  layouts = layouts,
}
