require 'torch'
require 'nn'

local TestCallLua = torch.class('TestCallLua')

function TestCallLua:__init(someName)
  print('TestCallLua:__init(', someName, ')')
  self.someName = someName
end

function TestCallLua:getName()
  return self.someName
end

function TestCallLua:getOut(inTensor, outSize, kernelSize)
  local inSize = inTensor:size(3)
  local m = nn.TemporalConvolution(inSize, outSize, kernelSize)
  m:float()
  local out = m:forward(inTensor)
  print('out from lua', out)
  return out
end

function TestCallLua:addThree(inTensor)
  local outTensor = inTensor + 3
  return outTensor
end

function TestCallLua:printTable(sometable, somestring, table2)
  for k, v in pairs(sometable) do
    print('TestCallLua:printTable ', k, v)
  end
  print('somestring', somestring)
  for k, v in pairs(table2) do
    print('TestCallLua table2 ', k, v)
  end
  return {bear='happy', result=12.345, foo='bar'}
end

function TestCallLua:getList(somelist)
  assert(type(somelist) == 'table')
  print('list in lua:')
  for i = 1, #somelist do
    print(i, somelist[i])
  end
  assert((somelist[1] - 3.1415) < 1e-7)
  assert(somelist[2] == '~Python\\omega')
  assert(somelist[3] == 42)

  table.insert(somelist, 'Lorem Ipsum')
  return somelist
end