package.path = package.path .. ';..\\?.lua'
simpleMovingAvg = require"simpleMovingAvg"

local numElements = 10
local data = {}
local result
local testPass = true

local function runTest(test, filter, input, output)
  print ("Test#", test)
  for i, value in ipairs(input) do
    result = filter:update(value)
    if (output[i] ~= result) then
	  print ("FAIL: expected:", output[i], " but got ", result)
	  return false
	end
  end
  
  -- Verify getValue function works.
  if (filter:getValue() ~= result) then
	print ("FAIL: expected:", output[i], " but got ", result)
	return false
  end
  print ("PASS")
  return true
end

-- Test Case #1
-- Create an SMA filter with 4 elements.
-- Input a sequence of positive values and confirm outputs
id=1
numElements = 4
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {0.25,0.75,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.25,9.75,10,10,10}
runTest (id, simpleMovingAvg.new(numElements), data, result)

-- Test Case #2
-- Create an SMA filter with 4 elements.
-- Input a sequence of negative & positive values and confirm outputs
id=2
numElements = 4
data = {3,5,4,1,-1,2,-6,-3,2,0,0,1}
result = {0.75,2,3,3.25,2.25,1.5,-1,-2,-1.25,-1.75,-0.25,0.75}
runTest (id, simpleMovingAvg.new(numElements), data, result)

-- Test Case #3
-- Create an SMA filter with 1 element.
-- Input a sequence of values and confirm outputs
-- With only 1 element, the output should equal input.
id=3
numElements = 1
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
runTest (id, simpleMovingAvg.new(numElements), data, result)

-- Test Case #4
-- Create an SMA filter with no elements.
-- Input a sequence of values and confirm outputs
-- With no element specified, the filter defaults to 1
-- With only 1 element, the output should equal input.
id=4
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
runTest (id, simpleMovingAvg.new(), data, result)

-- Test Case #5
-- Create an SMA filter with 0 elements.
-- Input a sequence of values and confirm outputs
-- With 0 elements, the filter defaults to 1
-- With only 1 element, the output should equal input.
id=5
numElements = 0
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
runTest (id, simpleMovingAvg.new(numElements), data, result)

-- Test Case #6
-- Create an SMA filter with -1 elements.
-- Input a sequence of values and confirm outputs
-- With 0 elements, the filter defaults to 1
-- With only 1 element, the output should equal input.
id=6
numElements = -1
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
runTest (id, simpleMovingAvg.new(numElements), data, result)

-- Test Case #7
-- Create an SMA filter with 4 elements.
-- Input a sequence of values and confirm outputs
-- Reset the filter
-- Input a sequence of values and confirm outputs
id=7.1
numElements = 4
data = {1,2,3,4,5,6,7,8,9,10,10,10,10,10,10}
result = {0.25,0.75,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.25,9.75,10,10,10}
sma = simpleMovingAvg.new(numElements)
runTest (id, sma, data, result)
sma:reset(5.5)
id=7.2
data = {8,9,10,11,12}
result = {2,4.25,6.75,9.5,10.5}
sma = simpleMovingAvg.new(numElements)
runTest (id, sma, data, result)

-- Test Case #8
-- Execute getValue and print functions on empty filter.
-- Verify print after filter is loaded.
id=8
numElements = 4
data = {1,2,3,4}
result = {0.25,0.75,1.5,2.5}
sma = simpleMovingAvg.new(numElements)
if (sma:getValue() ~= 0) then
  print ("FAIL")
end
sma:print()
runTest (id, sma, data, result)
sma:print()

