package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.dolphin = nil
local dolphin = require 'dolphin'

package.loaded.valuetypes = nil
local valuetypes = require 'valuetypes'
local V = valuetypes.V
local MV = valuetypes.MV
local Block = valuetypes.Block
local Value = valuetypes.Value
local MemoryValue = valuetypes.MemoryValue
local FloatType = valuetypes.FloatTypeBE
local UIntType = valuetypes.IntTypeBE
local UShortType = valuetypes.ShortTypeBE
local UByteType = valuetypes.ByteType
local SIntType = valuetypes.SignedIntTypeBE
local SShortType = valuetypes.SignedShortTypeBE
local SByteType = valuetypes.SignedByteType
local BinaryType = valuetypes.BinaryType

package.loaded.layouts = nil
local layoutsModule = require 'layouts'

local BFBB = subclass(dolphin.DolphinGame)

BFBB.supportedGameVersions = {
  na = 'GQPE78',
}

BFBB.layoutModuleNames = {'bfbb_layouts'}
BFBB.framerate = 60

function BFBB:init(options)
  dolphin.DolphinGame.init(self, options)

  local start = self:getGameStartAddress()
  self.start = start

  local addrs = {}
  self.addrs = addrs
  
  addrs["globals"] = start + 0x3C0558
  addrs["globals.camera.yaw_cur"] = addrs["globals"] + 0x1D4
  addrs["globals.pad0"] = addrs["globals"] + 0x31C
  addrs["globals.player"] = addrs["globals"] + 0x6E0
  addrs["globals.player.ent"] = addrs["globals.player"] + 0
  addrs["globals.player.ent.model"] = addrs["globals.player.ent"] + 0x24
  addrs["globals.player.ent.frame"] = addrs["globals.player.ent"] + 0x48
  addrs["globals.player.Health"] = addrs["globals.player"] + 0xFD0
  addrs["globals.player.bbowlInitVel"] = addrs["globals.player"] + 0x1308
  addrs["globals.player.IsBubbleBowling"] = addrs["globals.player"] + 0x140C
  addrs["globals.player.Inv_Shiny"] = addrs["globals.player"] + 0x1420
  addrs["globals.player.Inv_Spatula"] = addrs["globals.player"] + 0x1424
  addrs["globals.player.Inv_PatsSock_Total"] = addrs["globals.player"] + 0x14E4

  addrs["sBubbleBowlTimer"] = start + 0x3CB6CC
  addrs["gGameOstrich"] = start + 0x3CB8AC

  addrs["oob_state::shared::flags"] = start + 0x297E48

  addrs["sPadData"] = start + 0x292620
  --
  -- sPadData addresses have been replaced by globals.pad0 to fix stick twitching
  --
  -- for a version where only analog sticks use globals.pad0
  --   checkout 1ea2ed0907c4ce99caf258faa7caab4f9509918c 
  -- for a version where both analog sticks and buttons use sPadData
  --   checkout ea8008ca4652c586f02325fbf113bdbe36d5580d 
  --
  -- addrs["sPadData[0].button"] = addrs["sPadData"] + 0
  -- addrs["sPadData[0].button 2"] = addrs["sPadData"] + 1
  -- addrs["sPadData[0].stickX"] = addrs["sPadData"] + 2
  -- addrs["sPadData[0].stickY"] = addrs["sPadData"] + 3
  -- addrs["sPadData[0].substickX"] = addrs["sPadData"] + 4
  -- addrs["sPadData[0].substickY"] = addrs["sPadData"] + 5
  addrs["sPadData[0].triggerLeft"] = addrs["sPadData"] + 6
  addrs["sPadData[0].triggerRight"] = addrs["sPadData"] + 7
end

function BFBB:toCEAddress(dolphinAddr)
  return dolphinAddr - 0x80000000 + self.start
end

function BFBB:updateAddresses()
  self.addrs["globals.pad0->pressed"] = nil
  self.addrs["globals.pad0->released"] = nil
  self.addrs["globals.pad0->analog1.x"] = nil
  self.addrs["globals.pad0->analog1.y"] = nil
  self.addrs["globals.pad0->analog2.x"] = nil
  self.addrs["globals.pad0->analog2.y"] = nil
  self.addrs["globals.player.ent.model->Mat"] = nil
  self.addrs["globals.player.ent.model->Mat->pos.x"] = nil
  self.addrs["globals.player.ent.model->Mat->pos.y"] = nil
  self.addrs["globals.player.ent.model->Mat->pos.z"] = nil
  self.addrs["globals.player.ent.frame->vel.x"] = nil
  self.addrs["globals.player.ent.frame->vel.y"] = nil
  self.addrs["globals.player.ent.frame->vel.z"] = nil
  self.addrs["globals.player.ent.frame->rot.angle"] = nil

  local pad0 = utils.readIntBE(self.addrs["globals.pad0"])

  if pad0 ~= 0 then
    pad0 = self:toCEAddress(pad0)
    self.addrs["globals.pad0->pressed"] = pad0 + 0x30
    self.addrs["globals.pad0->released"] = pad0 + 0x34
    self.addrs["globals.pad0->analog1.x"] = pad0 + 0x38
    self.addrs["globals.pad0->analog1.y"] = pad0 + 0x39
    self.addrs["globals.pad0->analog2.x"] = pad0 + 0x3A
    self.addrs["globals.pad0->analog2.y"] = pad0 + 0x3B
  end

  local model = utils.readIntBE(self.addrs["globals.player.ent.model"])

  if model ~= 0 then
    model = self:toCEAddress(model)
    self.addrs["globals.player.ent.model->Mat"] = model + 0x4C
    
    local mat = utils.readIntBE(self.addrs["globals.player.ent.model->Mat"])

    if mat ~= 0 then
      mat = self:toCEAddress(mat)
      self.addrs["globals.player.ent.model->Mat->pos.x"] = mat + 0x30
      self.addrs["globals.player.ent.model->Mat->pos.y"] = mat + 0x34
      self.addrs["globals.player.ent.model->Mat->pos.z"] = mat + 0x38
    end
  end

  local frame = utils.readIntBE(self.addrs["globals.player.ent.frame"])

  if frame ~= 0 then
    frame = self:toCEAddress(frame)
    self.addrs["globals.player.ent.frame->vel.x"] = frame + 0xD4
    self.addrs["globals.player.ent.frame->vel.y"] = frame + 0xD8
    self.addrs["globals.player.ent.frame->vel.z"] = frame + 0xDC
    self.addrs["globals.player.ent.frame->rot.angle"] = frame + 0xB8
  end
end

local GV = BFBB.blockValues

local BFBBValue = subclass(MemoryValue)
BFBB.BFBBValue = BFBBValue

function BFBBValue:init(label, name, extraArgs)
  MemoryValue.init(self, label, 0)
  self.name = name

  if extraArgs ~= nil and extraArgs.safeToRead ~= nil then
    self.safeToRead = extraArgs.safeToRead
  end
end

function BFBBValue:isAddressValid(addr)
  return (addr ~= nil and
    addr >= self.game.start and
    addr < self.game.start + 0x20000000)
end

function BFBBValue:getAddress()
  return self.game.addrs[self.name]
end

function BFBBValue:isValid()
  return self:isAddressValid(self:getAddress()) and
    (self.safeToRead == nil or self:safeToRead())
end

-------------------------------------
----------- custom values -----------
-------- subclass(BFBBValue) --------
-------------------------------------

local StickXValue = subclass(BFBBValue)
BFBB.StickXValue = StickXValue

function StickXValue:get()
  return 128 + BFBBValue.get(self)
end


local StickYValue = subclass(BFBBValue)
BFBB.StickYValue = StickYValue

function StickYValue:get()
  return 128 - BFBBValue.get(self)
end

-------------------------------------
----------- simple values -----------
---------- subclass(Value) ----------
-------------------------------------

local ButtonValue = subclass(Value)
BFBB.ButtonValue = ButtonValue

function ButtonValue:init()
  Value.init(self)
  self.current = 0
end 

function ButtonValue:updateValue()
  -- mask in pressed buttons
  self.current = self.current | self.game.buttonPressed:get()
  -- mask out released buttons
  self.current = self.current & ~self.game.buttonReleased:get()

  self.value = self.current
end


local RotatedVelXValue = subclass(Value)
BFBB.RotatedVelXValue = RotatedVelXValue

function RotatedVelXValue:updateValue()
  local angle = self.game.camAngle:get()
  local s = math.sin(angle)
  local c = math.cos(angle)

  self.value = -self.game.xvel:get() * c + self.game.zvel:get() * s
end


local RotatedVelZValue = subclass(Value)
BFBB.RotatedVelZValue = RotatedVelZValue

function RotatedVelZValue:updateValue()
  local angle = self.game.camAngle:get()
  local s = math.sin(angle)
  local c = math.cos(angle)

  self.value = self.game.xvel:get() * s + self.game.zvel:get() * c
end


local HVelLengthValue = subclass(Value)
BFBB.HVelLengthValue = HVelLengthValue

function HVelLengthValue:updateValue()
  local angle = self.game.camAngle:get()
  local x = self.game.xvel:get()
  local z = self.game.zvel:get()

  self.value = math.sqrt(math.pow(x, 2) + math.pow(z, 2))
end


local VVelLengthValue = subclass(Value)
BFBB.VVelLengthValue = VVelLengthValue

function VVelLengthValue:updateValue()
  self.value = self.game.yvel:get()
end


local ZeroValue = subclass(Value)
BFBB.ZeroValue = ZeroValue

function ZeroValue:updateValue()
  self.value = 0
end


local HansStateStrValue = subclass(Value)
BFBB.HansStateStrValue = HansStateStrValue

function HansStateStrValue:updateValue()
  v = self.game.hansState:get()
  s = tostring(v)
  if v == 3 then
    s = "Enabled (" .. s .. ")"
  elseif v == 7 then
    s = "Disabled (" .. s .. ")"
  end
  self.value = s
end

-- override to prevent unnecessary string conversion
function HansStateStrValue:displayValue(options)
  return self.value
end

-------------------------------------
---------- value functions ----------
-------------------------------------

function value(label, offset, typeMixinClass, safeToRead, extraArgs)
  if extraArgs == nil then
    extraArgs = {}
  end

  extraArgs.safeToRead = safeToRead

  return MV(label, offset, BFBBValue, typeMixinClass, extraArgs)
end

function customvalue(label, offset, valueClass, typeMixinClass, safeToRead, extraArgs)
  if extraArgs == nil then
    extraArgs = {}
  end

  extraArgs.safeToRead = safeToRead

  return MV(label, offset, valueClass, typeMixinClass, extraArgs)
end

function simplevalue(label, valueClass)
  v = V(valueClass)
  v.label = label
  return v
end

function playerEntSafeToRead(value)
  return utils.readIntBE(value.game.addrs["gGameOstrich"]) == 2
end

GV.health = value("Health", "globals.player.Health", UIntType)
GV.bowlingState = value("Bowling State", "globals.player.IsBubbleBowling", SIntType)
GV.bowlingSpeed = value("Bowl Speed", "globals.player.bbowlInitVel", FloatType)
GV.bowlingDamp = value("Bowl Dampen", "sBubbleBowlTimer", FloatType)
GV.shinyObjects = value("Shiny Objects", "globals.player.Inv_Shiny", UIntType)
GV.spatulas = value("Spatulas", "globals.player.Inv_Spatula", UIntType)
GV.socks = value("Socks", "globals.player.Inv_PatsSock_Total", UIntType)
GV.xpos = value("X Position", "globals.player.ent.model->Mat->pos.x", FloatType, playerEntSafeToRead)
GV.ypos = value("Y Position", "globals.player.ent.model->Mat->pos.y", FloatType, playerEntSafeToRead)
GV.zpos = value("Z Position", "globals.player.ent.model->Mat->pos.z", FloatType, playerEntSafeToRead)
GV.xvel = value("X Momentum", "globals.player.ent.frame->vel.x", FloatType, playerEntSafeToRead)
GV.yvel = value("Y Momentum", "globals.player.ent.frame->vel.y", FloatType, playerEntSafeToRead)
GV.zvel = value("Z Momentum", "globals.player.ent.frame->vel.z", FloatType, playerEntSafeToRead)
GV.facingAngle = value("Facing Angle", "globals.player.ent.frame->rot.angle", FloatType, playerEntSafeToRead)
GV.camAngle = value("Camera angle", "globals.camera.yaw_cur", FloatType)
GV.hansState = value("Hans State", "oob_state::shared::flags", SIntType)
GV.hansStateStr = simplevalue("Hans State", HansStateStrValue)
GV.buttonPressed = value("Pressed", "globals.pad0->pressed", UIntType)
GV.buttonReleased = value("Released", "globals.pad0->released", UIntType)
GV.buttonBits = simplevalue("", ButtonValue)
GV.stickX = customvalue("X Stick", "globals.pad0->analog1.x", StickXValue, SByteType)
GV.stickY = customvalue("Y Stick", "globals.pad0->analog1.y", StickYValue, SByteType)
GV.xCStick = customvalue("X C-Stick", "globals.pad0->analog2.x", StickXValue, SByteType)
GV.yCStick = customvalue("Y C-Stick", "globals.pad0->analog2.y", StickYValue, SByteType)
GV.lShoulder = value("L Shoulder", "sPadData[0].triggerLeft", UByteType)
GV.rShoulder = value("R Shoulder", "sPadData[0].triggerRight", UByteType)
GV.xvelRot = simplevalue("", RotatedVelXValue)
GV.zvelRot = simplevalue("", RotatedVelZValue)
GV.hvelLength = simplevalue("Horizontal", HVelLengthValue)
GV.vvelLength = simplevalue("Vertical", VVelLengthValue)
GV.zero = simplevalue("", ZeroValue)

local HVelocityImage = subclass(layoutsModule.StickInputImage)
BFBB.HVelocityImage = HVelocityImage

function HVelocityImage:init(window, game, options)
  options = options or {}
  options.max = options.max or 15
  options.square = options.square or false

  layoutsModule.StickInputImage.init(self, window, game.xvelRot, game.zvelRot, options)
end

local VVelocityImage = subclass(layoutsModule.StickInputImage)
BFBB.VVelocityImage = VVelocityImage

function VVelocityImage:init(window, game, options)
  options = options or {}
  options.max = options.max or 15
  options.square = options.square or true
  options.sizex = 20

  layoutsModule.StickInputImage.init(self, window, game.zero, game.yvel, options)
end

return BFBB