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
  self:addLabel{x=20, y=240, fontSize=12}
  self:addItem(game.xvel)
  self:addItem(game.yvel)
  self:addItem(game.zvel)

  self:addLabel{x=10, y=310, fontSize=16}
  self:addItem("Bowling")
  self:addLabel{x=20, y=340, fontSize=12}
  self:addItem(game.bowlingState)
  self:addItem(game.bowlingSpeed)
  self:addItem(game.bowlingDamp)

  self:addLabel{x=10, y=410, fontSize=16}
  self:addItem("Misc")
  self:addLabel{x=20, y=440, fontSize=12}
  self:addItem(game.health)
  self:addItem(game.facingAngle)
  self:addItem(game.hansState)
  --self:addItem(game.buttons)
  
  self:addImage(InputDisplay, {"TronStyleNoDpad", self.game.buttonBits, self.game.stickX, self.game.stickY, self.game.xCStick, self.game.yCStick, self.game.lShoulder, self.game.rShoulder}, {x=0, y=550})
end

-- local VelocityDisplay = subclass(CompoundElement)

-- function InputDisplay:init(window, xvel, zvel, passedDisplayOptions)

--   self.xvel = xvel
--   self.zvel = zvel

--   self.displayOptions = {nolabel=true}
--   if passedDisplayOptions then
--     utils.updateTable(self.displayOptions, passedDisplayOptions)
--   end
  
--   self.background = createPicture()
--   -- self.background:loadFromFile(inputDirectory .. skin.backgroundFile)
  

-- end

return {
  layouts = layouts,
}
