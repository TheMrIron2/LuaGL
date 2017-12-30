------------------------------------------------------
-- Explosion
------------------------------------------------------

Explosion = Thing:clone()
--Explosion._collidables = {}

function Explosion:init()
  Thing.init(self)
  self._tmax = 60
  self._size = 30
  self._scale = 10
  self._rotationSpeed = 0
  self._rotation = math.random()*360
  return self
end

function Explosion:draw()
  local alpha = math.cos(self._t*90/self._tmax)
  gl.Color(1,1,.1, alpha*alpha) 
  gl.PointSize(2) 
  gl.Begin("POINTS")
  gl.Vertex( -1,  0, 0)
  gl.Vertex( -1, .4, 0)
  gl.Vertex(-.5,  1, 0)
  gl.Vertex(  0, .4, 0)
  gl.Vertex( .7, .4, 0)
  gl.Vertex(  1,  0, 0)
  gl.Vertex( .6,-.5, 0)
  gl.Vertex(-.2, -1, 0)
  gl.End() 
  return self
end

function Explosion:timeStep()
  Thing.timeStep(self)
  self._scale = self._size*math.sin(self._t*120/self._tmax)
  if self._t > self._tmax then
    self:destroy()
    if math.random() < .001*self._space._level then
      hole = Hole:clone():init()
      hole._position:copyFrom_(self._position)
      self:space():add_(hole)
    end
  end
  return self
end

function Explosion:collideWith_(aThing)
  if aThing._proto ~= Bullet then
    local force = 3/(1+math.sqrt(self:distanceSquaredTo_(aThing)))
    aThing:moveAwayFrom_(self, force/aThing._scale)
  end
end

