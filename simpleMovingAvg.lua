-------------------------------------------------------------------------------
-- Simple Moving Average Filter
--
-- This file contains a lua class for a Simple Moving Average Filter as
-- described here:
--   http://en.wikipedia.org/wiki/Moving_average#Simple_moving_average
--
-- The class is instantiated (@{new}) with the number of elements to include in the
-- average.  Then the @{update} function is called with each new value to
-- input to the filter.
-- 
-- @classmod simpleMovingAvg
-- @author Troy Manary
--
-------------------------------------------------------------------------------
local simpleMovingAvg = {}
simpleMovingAvg.__index = simpleMovingAvg

-------------------------------------------------------------------------------
-- Calculates the sum of a sequence of numbers.
-- Works recursively over an unlimited list.
-- @function sumSeq
-- @local
-- @param seq sequence of numbers (int or float)
-- @return sum of numbers
-- @usage local sum = sumSeq(1.1, 2.3, 0.5, 6.9)
local function sumSeq(a, b, ...)
  if b then
    return sumSeq(a+b, ...)
  else
    return a
  end
end

-------------------------------------------------------------------------------
-- Constructor
-- @function new
-- @param Number of Elements to include in the simple moving average.
-- @return pointer to self
-- @usage local sma = simpleMovingAvg.new(10)
function simpleMovingAvg.new(numElements)
  numElements = numElements or 1
  if (numElements < 1) then numElements = 1 end
  local self = setmetatable({}, simpleMovingAvg)
  self.numElements = numElements
  self.elements = {}
 return self
end

-------------------------------------------------------------------------------
-- Removes all history from filter and sets the current value.
-- @function reset
-- @param value a new value to initialize the filter
-- @return nothing
-- @usage sma:reset(3.14)
function simpleMovingAvg.reset(self)
  self.elements = {}
end

-------------------------------------------------------------------------------
-- Update the filter with a new input value and return the current filter value.
-- @function update
-- @param value a new value to initialize the filter
-- @return current: filtered value over the specified number of elements.
-- @usage newVal = sma:update(17.112)
function simpleMovingAvg.update(self, value)
  value = value or 0
  if #self.elements == self.numElements then
    table.remove(self.elements, 1)
  end
  self.elements[#self.elements + 1] = value
  return sumSeq(unpack(self.elements)) / self.numElements
end

-------------------------------------------------------------------------------
-- Return the current filter value.
-- @function getValue
-- @return average current filtered value over the specified number of elements.
-- @usage newVal = sma:getValue()
function simpleMovingAvg.getValue(self)
  if (#self.elements ~= 0) then
    return sumSeq(unpack(self.elements)) / #self.elements
  else
	return 0
  end
end

-------------------------------------------------------------------------------
-- Print the current filter value
-- @function print
-- @return nothing
-- @usage sma:print()
function simpleMovingAvg.print(self)
  if (#self.elements ~= 0) then
    print(sumSeq(unpack(self.elements)) / #self.elements)
  else
    print(0)
  end
end

return simpleMovingAvg