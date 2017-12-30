collectgarbage(1000)
dofile("host:asteroids/clone.lua")
dofile("host:asteroids/Point.lua")
dofile("host:asteroids/Thing.lua")
dofile("host:asteroids/Asteriod.lua")
dofile("host:asteroids/Ship.lua")
dofile("host:asteroids/Saucer.lua")
dofile("host:asteroids/Bullet.lua")
dofile("host:asteroids/Explosion.lua")
dofile("host:asteroids/Hole.lua")
dofile("host:asteroids/Space.lua")
dofile("host:asteroids/Screen.lua")

function key(k, x, y)  Screen:key(k, x, y); end
function keyup(k, x, y)  Screen:keyup(k, x, y); end
function skey(k, x, y) Screen:skey(k, x, y); end
function reshape(w, h) Screen:reshape(w, h); end
function display()     Screen:display(); end
function timer(value)  Screen:timer(value); end

Screen:start()
