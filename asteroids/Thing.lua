
------------------------------------------------------
-- Thing
------------------------------------------------------

Thing =
{
  clone = clone,
  _space = nil,
  _position = nil,
  _velocity = nil,
  _rotation = 0,
  _rotationSpeed = 0,
  _scale = 20,
  _t = 0,
  _proto = Thing,
  _collidables = {},
}

function Thing:clone()
  local newObject = clone(self)
  newObject._proto = self
  return newObject
end

function Thing:init()
  self._t = 1
  self._position = Point:clone():x_y_(100, 100)
  self._velocity = Point:clone():x_y_(0, 0)
  self._rotationSpeed = 1
  return self
end

function Thing:radius()
  return self._scale
end

function Thing:space_(space)
  self._space = space
  return self
end

function Thing:space()
  return self._space
end

function Thing:display()
  gl.PushMatrix()
  local scale = self._scale
  gl.Translate(self._position._x, self._position._y, 0)
  gl.Rotate(self._rotation, 0, 0, 1)
  gl.Scale(scale, scale, 1)
  self:draw()
  gl.PopMatrix()
  return self
end

function Thing:draw()
  glBegin(GL_LINE_LOOP)
  glVertex(-1, -1, 0)
  glVertex(-1,  1, 0)
  glVertex( 1,  1, 0)
  glVertex( 1, -1, 0)
  glEnd() 
  return self
end

function Thing:timeStep()
  self._t = self._t + 1
  self._position._x = self._position._x + self._velocity._x
--print ("x: ".. self._position._x.."\n")
  self._position._y = self._position._y + self._velocity._y
--print ("y: ".. self._position._y.."\n")
  self._rotation = self._rotation + self._rotationSpeed
--print ("rotation: ".. self._rotation.."\n")
  return self
end

function Thing:distanceSquaredTo_(thing)
  return self._position:distanceSquaredTo_(thing._position)
end

function Thing:collideWith_(thing)
end

function Thing:destroy()
  self:space():remove_(self)
end

function Thing:create()
  self:space():add_(self)
end

function Thing:moveTowards_(aThing)
    local p = Point:clone()
    p:copyFrom_(aThing._position):subtract_(self._position)
    p:normalize():scaleBy_(1/4)
    self._velocity:add_(p)
end

function Thing:moveAwayFrom_(aThing, value)
    if value == nil then value = .25 end
    local p = Point:clone()
    p:copyFrom_(aThing._position):subtract_(self._position)
    p:normalize():scaleBy_(value):negate()
    self._velocity:add_(p)
end

function Thing:explode()
    local explosion = Explosion:clone():init()
    explosion:space_(self._space)
    explosion._position:copyFrom_(self._position)
    explosion._velocity:zero()
    explosion._size = self._scale 
    explosion:create()
    return explosion
end

function Thing:collideWith_(thing)
  if self._collidables[thing._proto] == 1 then
    self:doCollisionWith_(thing)
  end
end

function Thing:doCollisionWith_(thing)
end

