# LuaGL
PS2 library that provides access to the OpenGL 1.x library via Lua. Retrieved from the now-defunct ps2dev.org as I could not find the source code.

Taken from the original readme:

What is it
~~~~
A port of the LuaGL module (version v1.01) to Playstation 2.

What does it do
~~~~
See it in action by trying the asteroids example:
	./asteroids.sh

What else can it do
~~~~
LuaGL.elf can execute byte compiled scripts or compile them at
runtime.  I have provided a non-compiled example that may run on
other platforms.

Any of the basic GL routines may work.  Be cautious of anything not
used by the asteroids example.

I also patched in another module of mine, LuaPad.  This allows you
to use the game pad.

UPDATE

Also added is LuaKeyboard and LuaScr... look at the included CLI,
default.lua.

Requirements
~~~~
Composite video output, gamepad and the scripts to be loaded from host:

It doesn't work!
~~~~
I use a PAL PS2 running ps2link, and I upload via ps2client from a
unix environment.  Let me know if it works in a different environment.

If you suspect these conditions are not at fault, I'd suggest trying
these things:

 - check the gamepad
 - check your usbd.irx and ps2kbd.irx if you are trying to use a keyboard
 - use ps2link with ps2client
 - private message me on #ps2dev or forums.ps2dev.org with all of the details.
 - remember, all of the details

Limitations
~~~~
Lua scripts compiled on platforms other than PS2 are unlikely to
execute on PS2.

Doing all the GL calls and collision detection in Lua is slow.

Future
~~~~
Open Dynamics Engine for complicated shapes and faster collision detection.

Who am I
~~~
rinco

When did this happen
~~~~
Started project on 14th of Dec 2004.
Completed milestone "Asteroids" on 13th of Jan 2005.
Packaged binary and published on 26th of Jan 2005.
Added Keyboard and Scr modules on 10th of Feb 2005.

Apologies
~~~~
Sorry about the printf()s.

Thanks 
~~~~
The Lua team - Lua and LuaGL
Pixel - for porting Lua 
Dreamtime - DreamGL
#ps2dev - Help
Yindo.com - Asteroids example

Licenses
~~~~
LuaGL is a free software and uses the MIT License. It can be used at no cost for both academic and commercial purposes.
The Asteroids Lua implementation I have used is from Yindo.com (and updated).  Yindo please contact me!
Asteroids is a trademark of Atari.  
DreamGL is AFL.
