------------------------------------------------------
-- Point
------------------------------------------------------

Point =
{ 
  clone = clone,
  _x = 0, 
  _y = 0 
}

function Point:x_(x)
  self._x = x
  return self
end

function Point:y_(y)
  self._y = y
  return self
end

function Point:x_y_(x, y)
  self._x = x
  self._y = y
  return self
end

function Point:xy()
  return self._x, self._y
end

function Point:random()
  self._x = math.random()-.5
  self._y = math.random()-.5
  return self
end

function Point:scaleBy_(v)
  self._x = self._x * v
  self._y = self._y * v
  return self
end

function Point:add_(point)
  self._x = self._x + point._x
  self._y = self._y + point._y
  return self
end

function Point:subtract_(point)
  self._x = self._x - point._x
  self._y = self._y - point._y
  return self
end

function Point:normalize()
  local r = self:distanceFromOrigin()
  self._x = self._x/r
  self._y = self._y/r
  return self
end

function Point:negate()
  self._x = - self._x
  self._y = - self._y
  return self
end

function Point:zero()
  self._x = 0
  self._y = 0
  return self
end

function Point:copyFrom_(point)
  self._x = point._x
  self._y = point._y
  return self
end

function Point:rotate_(angle)
  local r = self:distanceFromOrigin()
  self._x = r * math.cos(angle)
  self._y = r * math.sin(angle)
  return self
end

function Point:distanceFromOrigin()
  local x, y = self:xy()
  return math.sqrt((x*x) + (y*y))
end

function Point:distanceSquaredTo_(point)
  local x1, y1 = self:xy()
  local x2, y2 = point:xy()
  local x, y = x1 - x2, y1 - y2
  return ((x*x) + (y*y))
end

function Point:distanceTo_(point)
  local x1, y1 = self:xy()
  local x2, y2 = point:xy()
  local x, y = x1 - x2, y1 - y2
  return math.sqrt((x*x) + (y*y))
end
