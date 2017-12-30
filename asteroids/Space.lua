------------------------------------------------------
-- Space
------------------------------------------------------

Space = 
{
  clone = clone,
  _things = {},
  _deadThings = {},
  _newThings = {},
  _screen = nil,
  _ship = Ship:clone():init(),
  _level = 0,
  _score = 0,
  _timeSinceDeath = 0,
}

function Space:ship()
  return self._ship
end

function Space:init()
  self._things = {}
  self._deadThings = {}
  self._newThings = {}
  return self
end

function Space:start()
  self:newLevel()
  return self
end

function Space:newShip()
  self._ship = Ship:clone():init()
  self._ship._position:x_(self._screen._width/2)
  self._ship._position:y_(self._screen._height/2)
  self:add_(self._ship)
end

function Space:newLevel()
  self._level = self._level + 1
  local n = 1
  while n < self._level * 3 do
    self:add_(Asteriod:clone():init())
    n = n + 1
  end
  return self
end

function Space:add_(thing)
  self._newThings[thing] = 1
  thing:space_(self)
  return self
end

function Space:remove_(thing)
  if thing == self._ship then 
    self._ship = nil
    self._timeSinceDeath = 0
  end
  self._deadThings[thing] = 1
  return self
end


function Space:screen_(screen) self._screen = screen; return self; end
function Space:screen() return self._screen; end

function Space:draw()
  self._timeSinceDeath = self._timeSinceDeath + 1
  if self._timeSinceDeath == 100 then
    self:newShip() 
  end


  gl.PushMatrix()
  local count = 0
  local thing, v = next(self._things, nil)
  while thing do
    count = count + 1
    thing:display()
    thing:timeStep()
    self:boundsCheck_(thing)
    thing, v = next(self._things, thing)
  end
  if count == 1 then
    self:newLevel()
  end

  self:collisionChecks()
  self:removeDeadThings()
  self:addNewThings()

  if math.random() < .0005*self._level then
    self:add_(Saucer:clone():init())
    if math.random() < .1 then
      self:add_(Hole:clone():init())
    end
  end


  gl.PopMatrix()
  glut.PostRedisplay()
end

function Space:collisionChecks()
  local thing1, v = next(self._things, nil)
  while thing1 do
    local thing2, v = next(self._things, thing1)
    while thing2 do
      if thing1._proto ~= thing2._proto then
        local r = thing1._scale + thing2._scale
        r = r*r
        if  thing1:distanceSquaredTo_(thing2) < r then
          thing1:collideWith_(thing2)
          thing2:collideWith_(thing1)
        end
      end
      thing2, v = next(self._things, thing2)
    end
    thing1, v = next(self._things, thing1)
  end
end

function Space:removeDeadThings()
  local thing, v = next(self._deadThings, nil)
  while thing do
    self._things[thing] = nil
    thing, v = next(self._deadThings, thing)
  end
  self._deadThings = {}
end

function Space:addNewThings()
  local thing, v = next(self._newThings, nil)
  while thing do
    self._things[thing] = 1
    thing, v = next(self._newThings, thing)
  end
  self._newThings = {}
end

function Space:boundsCheck_(thing)
  local room = 30
  if thing._position._x > self._screen._width + room then
    thing._position._x = - room
  elseif thing._position._x < - room then
    thing._position._x = self._screen._width + room
  elseif thing._position._y > self._screen._height + room then
    thing._position._y = - room
  elseif thing._position._y < - room then
    thing._position._y = self._screen._height + room
  end
end

function Space:key(k, x, y)
  if self._ship then self._ship:key(k, x, y) end
end

function Space:keyup(k, x, y)
  if self._ship then self._ship:keyup(k, x, y) end
end

function Space:skey(key, x, y)
  if self._ship then self._ship:skey(key, x, y) end
end
