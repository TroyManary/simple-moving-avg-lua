local simpleMovingAvg = {}
simpleMovingAvg.__index = simpleMovingAvg

local function sumSeq(a, b, ...)
  if b then
    return sumSeq(a+b, ...)
  else
    return a
  end
end

function simpleMovingAvg.new(numElements)
  numElements = numElements or 1
  local self = setmetatable({}, simpleMovingAvg)
  self.numElements = numElements
  self.elements = {}
 return self
end

function simpleMovingAvg.reset(self, value)
  value = value or 0
  self.elements = {}
end

function simpleMovingAvg.update(self, value)
  value = value or 0
  if #self.elements == self.numElements then
    table.remove(self.elements, 1)
  end
  
  self.elements[#self.elements + 1] = value
  return sumSeq(unpack(self.elements)) / self.numElements
end

function simpleMovingAvg.getValue(self)
  return simpleMovingAvg.sumSeq(unpack(self.elements)) / #self.elements
end

function simpleMovingAvg.print(self)
  print(simpleMovingAvg.sumSeq(unpack(self.elements)) / #self.elements)
end

return simpleMovingAvg