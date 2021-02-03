package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.layouts = nil
local layoutsModule = require 'layouts'
local Layout = layoutsModule.Layout

package.loaded.inputDisplayModule = nil
local inputDisplayModule = require 'inputdisplay'
local InputDisplay = inputDisplayModule.InputDisplay

local layouts = {}

layouts.normal = subclass(Layout)
layouts.normal.labelPadding = 0
function layouts.normal:init()
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  self.window:setSize(400, 800)

  local game = self.game
  game:setLabelPadding(0)
  
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
  -- self:addLabel{x=155, y=275, fontSize=12}
  -- self:addItem(game.xvel)
  -- self:addItem(game.yvel)
  -- self:addItem(game.zvel)
  
  self:addLabel{x=35, y=240, fontSize=12}
  self:addItem("Horizontal")
  self:addLabel{x=158, y=240, fontSize=12}
  self:addItem("Vertical")
  self:addLabel{x=37, y=370, fontSize=12}
  self:addItem(game.hvelLength, {nolabel=true})
  self:addLabel{x=152, y=370, fontSize=12}
  self:addItem(game.vvelLength, {nolabel=true})

  self:addLabel{x=10, y=390, fontSize=16}
  self:addItem("Bowling")
  self:addLabel{x=20, y=420, fontSize=12}
  self:addItem(game.bowlingState)
  self:addItem(game.bowlingSpeed)
  self:addItem(game.bowlingDamp)

  self:addLabel{x=10, y=490, fontSize=16}
  self:addItem("Misc")
  self:addLabel{x=20, y=520, fontSize=12}
  self:addItem(game.health)
  self:addItem(game.facingAngle)
  -- self:addItem(game.camAngle)
  -- self:addItem(game.hansState)
  self:addItem(game.hansStateStr)
  -- self:addItem(game.buttonPressed)
  -- self:addItem(game.buttonReleased)

  self:addLabel{foregroundColor=0x000000}
  -- Momentum Vectors: to adjust scaling change max - vector will scale in range(0, max)
  self:addImage(self.game.HVelocityImage, {game}, {max=11.5, lineThickness=2, foregroundColor=0x000000, x=20, y=265})
  self:addImage(self.game.VVelocityImage, {game}, {max=11.5, lineThickness=2, foregroundColor=0x000000, x=175, y=265})
  
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
      {x=10, y=640})
end

-- compatibility
layouts.test = layouts.normal


layouts.mono = subclass(Layout)
function layouts.mono:init()
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  self.window:setSize(400, 800)
  self.labelDefaults = {fontName="Consolas"}

  local game = self.game
  game:setLabelPadding(14)
  
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
  -- self:addLabel{x=155, y=275, fontSize=12}
  -- self:addItem(game.xvel)
  -- self:addItem(game.yvel)
  -- self:addItem(game.zvel)
  
  self:addLabel{x=28, y=240, fontSize=12}
  self:addItem("Horizontal")
  self:addLabel{x=152, y=240, fontSize=12}
  self:addItem("Vertical")
  self:addLabel{x=20, y=370, fontSize=12}
  self:addItem(game.hvelLength, {nolabel=true})
  self:addLabel{x=135, y=370, fontSize=12}
  self:addItem(game.vvelLength, {nolabel=true})

  self:addLabel{x=10, y=395, fontSize=16}
  self:addItem("Bowling")
  self:addLabel{x=20, y=425, fontSize=12}
  self:addItem(game.bowlingState)
  self:addItem(game.bowlingSpeed)
  self:addItem(game.bowlingDamp)

  self:addLabel{x=10, y=495, fontSize=16}
  self:addItem("Misc")
  self:addLabel{x=20, y=525, fontSize=12}
  self:addItem(game.health)
  self:addItem(game.facingAngle)
  -- self:addItem(game.camAngle)
  -- self:addItem(game.hansState)
  self:addItem(game.hansStateStr)
  -- self:addItem(game.jumpPower)
  -- self:addItem(game.buttonPressed)
  -- self:addItem(game.buttonReleased)

  self:addLabel{foregroundColor=0x000000}
  -- Momentum Vectors: to adjust scaling change max - vector will scale in range(0, max)
  self:addImage(self.game.HVelocityImage, {game}, {max=11.5, lineThickness=2, foregroundColor=0x000000, x=20, y=265})
  self:addImage(self.game.VVelocityImage, {game}, {max=11.5, lineThickness=2, foregroundColor=0x000000, x=175, y=265})
  
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
      {x=10, y=645})
end



layouts.render = subclass(Layout)
function layouts.render:init()
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  self.window:setSize(1700, 1050)
  self.labelDefaults = {fontName="Consolas"}

  local game = self.game
  game:setLabelPadding(14)
  local labelFontSize = 30
  local textFontSize = 23
  local layoutScale = 1.7

  self:addLabel{x=10*layoutScale, y=10*layoutScale, fontSize=labelFontSize}
  self:addItem("Collectables")
  self:addLabel{x=20*layoutScale, y=40*layoutScale, fontSize=textFontSize}
  self:addItem(game.spatulas)
  self:addItem(game.shinyObjects)
  self:addItem(game.socks)

  self:addLabel{x=10*layoutScale, y=110*layoutScale, fontSize=labelFontSize}
  self:addItem("Position")
  self:addLabel{x=20*layoutScale, y=140*layoutScale, fontSize=textFontSize}
  self:addItem(game.xpos)
  self:addItem(game.ypos)
  self:addItem(game.zpos)

  self:addLabel{x=10*layoutScale, y=210*layoutScale, fontSize=labelFontSize}
  self:addItem("Momentum")
  -- self:addLabel{x=155*layoutScale, y=275*layoutScale, fontSize=textFontSize}
  -- self:addItem(game.xvel)
  -- self:addItem(game.yvel)
  -- self:addItem(game.zvel)
  
  self:addLabel{x=25*layoutScale, y=240*layoutScale, fontSize=textFontSize}
  self:addItem("Horizontal")
  self:addLabel{x=149*layoutScale, y=240*layoutScale, fontSize=textFontSize}
  self:addItem("Vertical")
  self:addLabel{x=17*layoutScale, y=370*layoutScale, fontSize=textFontSize}
  self:addItem(game.hvelLength, {nolabel=true})
  self:addLabel{x=132*layoutScale, y=370*layoutScale, fontSize=textFontSize}
  self:addItem(game.vvelLength, {nolabel=true})

  self:addLabel{x=10*layoutScale, y=395*layoutScale, fontSize=labelFontSize}
  self:addItem("Bowling")
  self:addLabel{x=20*layoutScale, y=425*layoutScale, fontSize=textFontSize}
  self:addItem(game.bowlingState)
  self:addItem(game.bowlingSpeed)
  self:addItem(game.bowlingDamp)

  self:addLabel{x=10*layoutScale, y=495*layoutScale, fontSize=labelFontSize}
  self:addItem("Misc")
  self:addLabel{x=20*layoutScale, y=525*layoutScale, fontSize=textFontSize}
  self:addItem(game.health)
  self:addItem(game.facingAngle)
  -- self:addItem(game.camAngle)
  -- self:addItem(game.hansState)
  self:addItem(game.hansStateStr)
  -- self:addItem(game.jumpPower)
  -- self:addItem(game.buttonPressed)
  -- self:addItem(game.buttonReleased)

  self:addLabel{foregroundColor=0x000000}
  -- Momentum Vectors: to adjust scaling change max - vector will scale in range(0, max)
  self:addImage(self.game.HVelocityImage, {game}, {max=11.5, lineThickness=3, foregroundColor=0x000000, x=20*layoutScale, y=265*layoutScale, size=100*layoutScale})
  self:addImage(self.game.VVelocityImage, {game}, {max=11.5, lineThickness=3, foregroundColor=0x000000, x=175*layoutScale, y=265*layoutScale, sizex=20*layoutScale, sizey=100*layoutScale})
  
  self:addImage(InputDisplay,
      {"TronStyleNoDpadUpscaled",
        self.game.buttonBits,
        self.game.stickX,
        self.game.stickY,
        self.game.xCStick,
        self.game.yCStick,
        self.game.lShoulder,
        self.game.rShoulder
      },
      {x=710, y=0})

end

function layouts.render:update()
  Layout.update(self)
  if RenderOptions == nil or
      RenderOptions.dumpFrames == nil or
      not RenderOptions.dumpFrames then
    print("debug")
    return
  end

  if RenderOptions.nirCmdDirectory == nil or string.len(RenderOptions.nirCmdDirectory) == 0 then
    error("Please specify nirCmdDirectory path (ending with nircmd.exe)")
  end
  if RenderOptions.imgOutDirectory == nil or string.len(RenderOptions.imgOutDirectory) == 0 then
    error("Please specify imgOutDirectory path to save screenshots to")
  end

  local imgOut = string.format("frame%015d.png", self.game:getFrameCount() - 1)
  local imgOut = "\"" .. RenderOptions.imgOutDirectory .. "\\" .. imgOut .. "\""
  local cmd = "\"" .. RenderOptions.nirCmdDirectory .. "\"" .. " savescreenshotfull " .. imgOut

  os.execute("\"" .. cmd .. "\"")
end

return {
  layouts = layouts,
}
