package.loaded.layouts = nil
local layouts = require "layouts"
package.loaded.utils = nil
local utils = require "utils"
local readIntBE = utils.readIntBE
local subclass = utils.subclass
local CompoundElement = layouts.CompoundElement
local SimpleElement = layouts.SimpleElement



-- Display a memory value using per-character images (effectively a bitmap font).
local ImageValueDisplay = subclass(CompoundElement)

function ImageValueDisplay:init(window, memoryValue, numCharacters, passedDisplayOptions)
  -- This can be any kind of MemoryValue. The only constraint is that all the possible
  -- characters that can be displayed are covered in the charImages defined below.
  self.memoryValue = memoryValue
  -- Max number of characters to show in this display. This is how many Image objects
  -- we'll maintain.
  self.numCharacters = numCharacters
  -- display options to pass into the memory value's display() method.
  self.displayOptions = {nolabel=true}
  if passedDisplayOptions then
    utils.updateTable(self.displayOptions, passedDisplayOptions)
  end

FontDirectory = RWCEMainDirectory .. '/font_skin'
  self.charImageFiles = {
    ['0'] = FontDirectory .. '/0.png',
    ['1'] = FontDirectory .. '/1.png',
    ['2'] = FontDirectory .. '/2.png',
    ['3'] = FontDirectory .. '/3.png',
    ['4'] = FontDirectory .. '/4.png',
    ['5'] = FontDirectory .. '/5.png',
    ['6'] = FontDirectory .. '/6.png',
    ['7'] = FontDirectory .. '/7.png',
    ['8'] = FontDirectory .. '/8.png',
    ['9'] = FontDirectory .. '/9.png',


    ['-'] = FontDirectory .. '/minus.png',
    ['.'] = FontDirectory .. '/coron.png',
    [' '] = FontDirectory .. '/empty.png',

  }

  self.charImages = {}
  for char, charImageFilepath in pairs(self.charImageFiles) do
    self.charImages[char] = createPicture()
    self.charImages[char]:loadFromFile(charImageFilepath)
  end
  -- Empty picture to represent a space
  self.charImages[''] = createPicture()

  local width = 48
  local height = 64
  for n=1, numCharacters do
    local uiObj = createImage(window)
    uiObj:setSize(width, height)
    -- Allow the image to stretch to fit the size
    uiObj:setStretch(false)
    local relativePosition = {width*(n-1), 0}
    self:addElement(relativePosition, uiObj)
 end
end

function ImageValueDisplay:update()
  local valueString = self.memoryValue:display(self.displayOptions)

  for n, element in pairs(self.elements) do
    if valueString:len() >= n then
      local char = valueString:sub(n, n)
      if self.charImages[char] == nil then
        error(
          "No image specified for '" .. char
          .. "' (full string: " .. valueString .. ")")
      end
      element.uiObj.setPicture(self.charImages[char])
    else
      element.uiObj.setPicture(self.charImages[''])
    end
  end
end
