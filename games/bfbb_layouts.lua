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

local RenderLayout = subclass(Layout)
function RenderLayout:update()
  Layout.update(self)
  if RenderOptions == nil or
      RenderOptions.dumpFrames == nil or
      not RenderOptions.dumpFrames then
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


layouts.render = subclass(RenderLayout)
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


layouts.spongeboy = subclass(RenderLayout)
function layouts.spongeboy:init()
  TableAddFont(RWCEMainDirectory .. "\\fonts\\Spongeboy Me Bob.ttf")
  TableAddFont(RWCEMainDirectory .. "\\fonts\\Some Time Later.otf")
  self:setBreakpointUpdateMethod()
  --self:activateAutoPositioningY()
  self.window:setSize(1700, 1050)
  self.labelDefaults = {fontName="Spongeboy Me Bob", foregroundColor=0xFFFFFF}
  -- self.labelDefaults = {fontName="Some Time Later", foregroundColor=0xFFFFFF}
  -- self.labelDefaults = {fontName="Consolas"}

  local game = self.game
  -- game:setLabelPadding(14)
  local labelPadding = 155
  local labelFontSize = 30
  local textFontSize = 23
  local layoutScale = 1.7
  local foregroundColor = 0xFFFFFF
  local backgroundColor = 0x00FF00

  self.window:setColor(backgroundColor)

  self:addLabel{x=10*layoutScale, y=10*layoutScale, fontSize=labelFontSize, fontColor=foregroundColor}
  self:addItem("Collectables")
  self:addLabel{x=20*layoutScale, y=40*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Spatulas")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=40*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.spatulas, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=60*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Shiny Objects")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=60*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.shinyObjects, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=80*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Socks")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=80*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.socks, {nolabel=true})

  self:addLabel{x=10*layoutScale, y=110*layoutScale, fontSize=labelFontSize, fontColor=foregroundColor}
  self:addItem("Position")
  self:addLabel{x=20*layoutScale, y=140*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("X Position")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=140*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.xpos, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=160*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Y Position")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=160*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.ypos, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=180*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Z Position")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=180*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.zpos, {nolabel=true})

  self:addLabel{x=10*layoutScale, y=210*layoutScale, fontSize=labelFontSize, fontColor=foregroundColor}
  self:addItem("Momentum")
  
  self:addLabel{x=25*layoutScale, y=240*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Horizontal")
  self:addLabel{x=149*layoutScale, y=240*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Vertical")
  self:addLabel{x=27*layoutScale, y=370*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.hvelLength, {nolabel=true})
  self:addLabel{x=142*layoutScale, y=370*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.vvelLength, {nolabel=true})

  self:addLabel{x=10*layoutScale, y=395*layoutScale, fontSize=labelFontSize, fontColor=foregroundColor}
  self:addItem("Bowling")
  self:addLabel{x=20*layoutScale, y=425*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Bowl State")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=425*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.bowlingState, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=445*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Bowl Speed")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=445*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.bowlingSpeed, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=465*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Bowl Damp")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=465*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.bowlingDamp, {nolabel=true})

  self:addLabel{x=10*layoutScale, y=495*layoutScale, fontSize=labelFontSize, fontColor=foregroundColor}
  self:addItem("Player")
  self:addLabel{x=20*layoutScale, y=525*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Health")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=525*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.health, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=545*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Facing Angle")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=545*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.facingAngle, {nolabel=true})
  self:addLabel{x=20*layoutScale, y=565*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem("Hans State")
  self:addLabel{x=(20 + labelPadding)*layoutScale, y=565*layoutScale, fontSize=textFontSize, fontColor=foregroundColor}
  self:addItem(game.hansStateStr, {nolabel=true})

  self:addLabel()
  -- Momentum Vectors: to adjust scaling change max - vector will scale in range(0, max)
  self:addImage(self.game.HVelocityImage, {game}, {max=11.5, lineThickness=3, foregroundColor=foregroundColor, backgroundColor=backgroundColor, x=20*layoutScale, y=265*layoutScale, size=100*layoutScale})
  self:addImage(self.game.VVelocityImage, {game}, {max=11.5, lineThickness=3, foregroundColor=foregroundColor, backgroundColor=backgroundColor, x=175*layoutScale, y=265*layoutScale, sizex=20*layoutScale, sizey=100*layoutScale})
  
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

function TableAddFont(path)
   if (type(path)=='string') then
      local font,filename
      font = findTableFile(path);
      if (not font) then
         local file = io.open(path,"r")
         if (not file) then
            error("ERROR loading font");
         else
            file:close();
            filename = path:match(".+\\(.-)$")
            font = findTableFile(filename)
            if (not font) then
               font = createTableFile(filename,path)
            end
         end
      end
      local frmt = (cheatEngineIs64Bit() and "mov edx,#%%d\nmov rcx,#%%d\nxor r8d,r8d\nlea r9d,[count]\ncall AddFontMemResourceEx\nmov [handle],rax" or "lea eax,[count]\npush eax\npush 0\npush #%%d\npush #%%d\ncall AddFontMemResourceEx\nmov [handle],eax")
      local pFont,length = font.stream.memory,font.stream.size
      local sAdd = "alloc(script,128)\nalloc(data,32)\nlabel(count)\nlabel(handle)\nregistersymbol(count)\nregistersymbol(handle)\nregistersymbol(script)\nscript:\n_FORMAT\nret\ndata:\ncount:\ndd -1\nhandle:\ndd -1\ncreatethread(script)"
      sAdd = sAdd:gsub("_FORMAT",frmt):format(length,pFont)
      local status = autoAssemble(sAdd,true);
      if (status) then
         local handle = readIntegerLocal("handle") or 0;
         return handle ~= 0
      end
      return false;
   end
end

return {
  layouts = layouts,
}
