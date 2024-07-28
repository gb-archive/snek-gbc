@ ECHO OFF
:: assemble all the asm files into object files
rgbasm -h -Wall -i inc -o obj\main.o code\main.sm83
rgbasm -h -Wall -i inc -o obj\init.o code\init.sm83
rgbasm -h -Wall -i inc -o obj\sub.o code\sub.sm83
rgbasm -h -Wall -i inc -o obj\vblank.o code\vblank.sm83
rgbasm -h -Wall -i inc -o obj\rand.o code\rand.sm83
:: link the files, spit out a rom, a sym, and a map
rgblink -p 0xFF -m bin\pong.map -n bin\pong.sym -o bin\pong.gb obj\main.o obj\init.o obj\sub.o obj\vblank.o obj\rand.o
:: "fix' the rom image (header and pad)
rgbfix -l 0x33 -j -c -s -v -p 0xFF -t "PONG TEST" bin/pong.gb
:: check the rom ussage (optional, i like how it looks)
romusage bin\pong.map -g
:: done! pause to let the user see any errors
pause