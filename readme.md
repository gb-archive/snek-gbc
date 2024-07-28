### snek-gbc

**Snek!** or **snek-gbc** is an open source snake clone for the game boy,
super game boy and game boy color consoles, written in assembly using rgbds

### compiling

to build Snek!, you will need:
- [RGBDS](https://github.com/gbdev/rgbds), v6.0.0 should work
- [SuperFamiconv](https://github.com/Optiroc/SuperFamiconv),
must be compiled from source (relies on a new feature for the SGB border)
- cmd or GNU make (v4.3 should work) (todo: add link)
- optionally, [romusage](https://github.com/bbbbbr/romusage), v1.2.4 should work

all of the above must be located in your PATH

as stated above, you can build with either make or cmd

if you have make:
1. run `make` in the repo root
2. open `bin/pong.gb` in your favourite emulator

if you have something that runs `.bat`s:
1. create folders `bin/`, `obj/` and `gfx/bin/`
2. run `gfx/_ALL.bat` to convert the assets
3. run `build.bat` to assemble, link and fix the rom
4. open `bin/pong.gb` in your favourite emulator

build artifacts will go in `bin/`, `obj/`, and `gfx/bin/`

the `.bat` files may get removed at any time with or without notice

### greets

thanks to [pino](https://github.com/pinobatch/), [leina](https://github.com/leinacc/),
and [isso](https://github.com/ISSOtm/) for helping with this in one way or another

and [evie](github.com/eievui5/) and [bella](https://github.com/ApianbelleDev/) for being epic

### misc

- a license should be added at some point, for now feel free to do reasonable things,
with credit *(obviously)*, and if youre unsure if you can/cant do something,
[just ask](https://github.com/zlago#links-to-socialswhatevs)