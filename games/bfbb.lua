package.loaded.utils = nil
local utils = require 'utils'
local subclass = utils.subclass

package.loaded.dolphin = nil
local dolphin = require 'dolphin'

package.loaded.valuetypes = nil
local valuetypes = require 'valuetypes'
local MV = valuetypes.MV
local Block = valuetypes.Block
local MemoryValue = valuetypes.MemoryValue
local FloatType = valuetypes.FloatTypeBE
local UIntType = valuetypes.IntTypeBE
local UShortType = valuetypes.ShortTypeBE
local UByteType = valuetypes.ByteType
local SIntType = valuetypes.SignedIntTypeBE
local SShortType = valuetypes.SignedShortTypeBE
local SByteType = valuetypes.SignedByteType
local BinaryType = valuetypes.BinaryType

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
  addrs["sPadData[0].button"] = addrs["sPadData"] + 0
  addrs["sPadData[0].button 2"] = addrs["sPadData"] + 1
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

function value(label, offset, typeMixinClass, safeToRead, extraArgs)
  if extraArgs == nil then
    extraArgs = {}
  end

  extraArgs.safeToRead = safeToRead

  return MV(label, offset, BFBBValue, typeMixinClass, extraArgs)
end

local StickXValue = subclass(BFBBValue)
BFBB.StickXValue = StickXValue

function StickXValue:get()
  return 128 + BFBBValue.get(self)
end

function stickxvalue(label, offset, safeToRead, extraArgs)
  if extraArgs == nil then
    extraArgs = {}
  end

  extraArgs.safeToRead = safeToRead

  return MV(label, offset, StickXValue, SByteType, extraArgs)
end

local StickYValue = subclass(BFBBValue)
BFBB.StickYValue = StickYValue

function StickYValue:get()
  return 128 - BFBBValue.get(self)
end

function stickyvalue(label, offset, safeToRead, extraArgs)
  if extraArgs == nil then
    extraArgs = {}
  end

  extraArgs.safeToRead = safeToRead

  return MV(label, offset, StickYValue, SByteType, extraArgs)
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
GV.facingAngle = value("Facing angle", "globals.player.ent.frame->rot.angle", FloatType, playerEntSafeToRead)
GV.hansState = value("Hans State", "oob_state::shared::flags", SIntType)
GV.ABXYS = value("ABXY & Start", "sPadData[0].button", BinaryType, nil, {binarySize=8, binaryStartBit=7})
GV.DZ = value("D-Pad & Z", "sPadData[0].button 2", BinaryType, nil, {binarySize=8, binaryStartBit=7})
-- GV.stickX = stickxvalue("X Stick", "sPadData[0].stickX")
-- GV.stickY = stickyvalue("Y Stick", "sPadData[0].stickY")
-- GV.xCStick = stickxvalue("X C-Stick", "sPadData[0].substickX")
-- GV.yCStick = stickyvalue("Y C-Stick", "sPadData[0].substickY")
GV.stickX = stickxvalue("X Stick", "globals.pad0->analog1.x")
GV.stickY = stickyvalue("Y Stick", "globals.pad0->analog1.y")
GV.xCStick = stickxvalue("X C-Stick", "globals.pad0->analog2.x")
GV.yCStick = stickyvalue("Y C-Stick", "globals.pad0->analog2.y")
GV.lShoulder = value("L Shoulder", "sPadData[0].triggerLeft", UByteType)
GV.rShoulder = value("R Shoulder", "sPadData[0].triggerRight", UByteType)

return BFBB