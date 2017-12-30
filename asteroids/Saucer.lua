------------------------------------------------------
-- Saucer
------------------------------------------------------

Saucer = Thing:clone()
Saucer._collidables = {}

function Saucer:init()
  Thing.init(self)
  self._generation = 1
  self._collidables[Bullet] = 1
  self._collidables[Asteriod] = 1
  self._collidables[Ship] = 1
  self._collidables[Saucer] = 1
  self._collidables[Explosion] = 1
  self._position:x_y_(2000*math.random(), 2000*math.random())
  self._velocity:x_y_(math.random()-.5, math.random()-.5)
  self._rotationSpeed = 0
  self._scale = 10
  return self
end

function Saucer:draw()
  gl.Color(.1,.1,1,.8)
  gl.Scale(math.sin(self._t*10), 1, 1)
  gl.Begin("LINE_LOOP")
  gl.Vertex( 0, .5, 0)
  gl.Vertex( 1, 0, 0)
  gl.Vertex( 0, -.5, 0)
  gl.Vertex(-1, 0, 0)
  gl.End() 

  gl.Color(1,.6,1,1)
  gl.PointSize(1)
  gl.Begin("POINTS")
  gl.Vertex( 0, .5, 0)
  gl.Vertex( 1, 0, 0)
  gl.Vertex( 0, -.5, 0)
  gl.Vertex(-1, 0, 0)
  gl.End() 

  return self
end

function Saucer:shootAt_(aThing)
    local bullet = Bullet:clone():init()
    bullet._tmax = 200
    bullet._position:copyFrom_(self._position)
    bullet._velocity:copyFrom_(aThing._position)
    bullet._velocity._x = bullet._velocity._x + (math.random()-.5)*50
    bullet._velocity._y = bullet._velocity._y + (math.random()-.5)*50
    bullet._velocity:subtract_(self._position)
    bullet._velocity:normalize():scaleBy_(2)
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    bullet:timeStep()
    self:space():add_(bullet)
end



function Saucer:timeStep()
  local ship = self:space():ship()
  if ship ~= nil then 
  if math.random() < .003 * self._generation then
    self:shootAt_(ship) 
  end
  if math.random() < .005 * self._generation then
    self:moveAwayFrom_(ship) 
  end
  end
  Thing.timeStep(self)
  self._rotationSpeed = self._rotationSpeed *.9
  self._velocity._x = self._velocity._x + (math.random()-.51)/10
  self._velocity._y = self._velocity._y + (math.random()-.51)/10
  self._velocity:normalize()
  return self
end

function Saucer:doCollisionWith_(thing)
  if thing._proto == Asteriod and self._generation < 10 then
    self._generation = self._generation + 1
    self._scale = self._scale + 1
  else
    self:explode()._size = self._scale * 5 
    self:explode()._size = self._scale * 7 
    self:explode()._size = self._scale * 3 
    self:destroy()
  end
end

