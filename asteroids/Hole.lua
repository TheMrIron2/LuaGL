------------------------------------------------------
-- Hole
------------------------------------------------------

Hole = Thing:clone()
Hole._collidables = {}

function Hole:init()
  Thing.init(self)
  self._collidables[Asteriod] = 1
  self._collidables[Ship] = 1
  self._collidables[Saucer] = 1
  self._collidables[Bullet] = 1
  self._size = 50
  self._scale = 50
  self._rotationSpeed = 0
  self._rotation = 0
  self._velocity:random()
  self._velocity:random()
  return self
end

function Hole:draw()
  local x1, y1 = self._position:xy()
  x1 = x1 / self._scale
  y1 = y1 / self._scale
  local d = 15
  local xo = (x1*d - math.floor(x1*d) )/d
  local yo = (y1*d - math.floor(y1*d) )/d
  --glTranslate(-xoffset, -yoffset, 0)

  local nMax = d
  local mMax = d

  local n = 1
  while n < nMax do
    local y = n/nMax - .5 - yo
    gl.Begin("LINE_STRIP")
    local m = 1
    while m < mMax do
      local x = m/mMax - .5 - xo
      local r2 = x*x + y*y
      local r = 1/(1+ r2*200)
      gl.Color(1,1,1, r) 

      gl.Vertex( x, y-(.01/(.02+r2)), 0)
      m = m + 1
    end
    gl.End() 
    n = n + 1
  end

  local n = 1
  while n < nMax do
    local y = n/nMax - .5 - yo
    gl.Begin("LINE_STRIP")
    local m = 1
    while m < mMax do
      local x = m/mMax - .5 - xo
      local r2 = x*x + y*y
      local r = 1/(1+ r2*100)
      gl.Color(1,1,1, r) 

      gl.Vertex( y, x-(.01/(.02+r2)), 0)
      m = m + 1
    end
    gl.End() 
    n = n + 1
  end


  return self
end


function Hole:timeStep()
  Thing.timeStep(self)
  local t = self._t
  if t > 1000 then
    self._scale = self._scale*.9
    if self._scale < 1 then
      self:destroy()
    end
  elseif t < 100 then
    self._scale = self._size*(t/100)
  end
  return self
end

function Hole:doCollisionWith_(aThing)
  --if random() < .5 then 
    aThing:moveTowards_(self) 
  --end
    if aThing._proto ~= Bullet then
    aThing._scale = aThing._scale *.95
    if aThing._scale < 3 then
      aThing:destroy()
    end
  end
end
