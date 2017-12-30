----------------------------------
-- define clone function
----------------------------------

function clone(aTable)
  local newTable = {}
  local i, v = next(aTable, nil)
  while i ~= nil do
    newTable[i] = v
    i, v = next(aTable, i)
  end
  if newTable["init"] ~= nil then
    newTable:init()
  end
  return newTable
end

----------------------------------
