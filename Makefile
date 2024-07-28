# rgbds defines
# flags
ASM_FLAGS  = -h -Wall -p ${PAD_VAL} $(addprefix -I,${INC_PATHS}) $(addprefix -D,${DEFINES})
LINK_FLAGS = -w -p ${PAD_VAL}
FIX_FLAGS  = -v -s -l 0x33 -j -c -t ${HDR_TITLE} -k ${HDR_LICENSEE} -m ${HDR_MBC} -r ${HDR_RAM} -n ${HDR_VER} -p ${PAD_VAL}
# include paths
INC_PATHS = inc/ gfx/bin/ gfx/
# (string?) constants for rgbasm
DEFINES = ${CONFIG}
# pad value
PAD_VAL = 0xFF

# ROM defines
# filename for the binary
BIN_NAME = pong
# name for the header
HDR_TITLE = "PONG TEST"
# new licensee code
HDR_LICENSEE = "ZS"
# mapper used
HDR_MBC = MBC5+RAM+BATTERY
# rgbfix will set ROM size for you
# RAM size
HDR_RAM = 2
# ROM version size
HDR_VER = 0

# dependencies
ASM_REQS = $(shell find code/ -name '*.inc')
LINK_REQS = $(patsubst code/%.sm83,obj/%.o,$(shell find code/ -name '*.sm83'))
GFX_REQS = gfx/bin/arrows.2bpp gfx/bin/bad.1bpp gfx/bin/base.2bpp gfx/bin/base.spal \
	gfx/bin/base.cpal gfx/bin/border.pal gfx/bin/border.4bpp gfx/bin/border.pct \
	gfx/bin/game.tilemap gfx/bin/gamestop.tilemap gfx/bin/gamestop.1bpp \
	gfx/bin/snake.2bpp gfx/bin/snake.spal gfx/bin/snake.cpal gfx/bin/statusbar.1bpp \
	gfx/bin/title.1bpp gfx/bin/title.tilemap

.PHONY: all clean

all: bin/${BIN_NAME}.gb

clean:
	rm -rf bin/
	rm -rf obj/
	rm -rf gfx/bin/

bin/:
	mkdir bin/

obj/:
	mkdir obj/

gfx/bin/:
	mkdir gfx/bin/

gfx/bin/arrows.2bpp: gfx/png/arrows.png gfx/bin/
	rgbgfx -v -o $@ $<

gfx/bin/bad.1bpp: gfx/png/bad.png gfx/bin/
	rgbgfx -v -d 1 -o $@ $<

gfx/bin/base.2bpp gfx/bin/base.spal: gfx/png/base.png gfx/bin/
	rgbgfx -v -o gfx/bin/base.2bpp -p gfx/bin/base.spal $<

gfx/bin/base.cpal: gfx/png/base.png gfx/bin/
	rgbgfx -v -C -p $@ $<

gfx/bin/border.pal gfx/bin/border.4bpp gfx/bin/border.pct: gfx/png/border.png gfx/bin/
	superfamiconv -v -i $< -p gfx/bin/border.pal -t gfx/bin/border.4bpp -P 4 -m gfx/bin/border.pct -M snes --color-zero 0000ff -B 4

gfx/bin/game.tilemap: gfx/png/game.png gfx/bin/base.2bpp gfx/base.dpal gfx/bin/
	superfamiconv map -v -M gb -i gfx/png/game.png -p gfx/base.dpal -t gfx/bin/base.2bpp -d $@ -B 2

gfx/bin/gamestop.tilemap gfx/bin/gamestop.1bpp: gfx/png/gamestop.png gfx/bin/
	rgbgfx -v -t gfx/bin/gamestop.tilemap -o gfx/bin/gamestop.1bpp $< -b 128 -d 1

gfx/bin/snake.2bpp gfx/bin/snake.spal: gfx/png/snake2.png gfx/bin/
	rgbgfx -v -o gfx/bin/snake.2bpp -p gfx/bin/snake.spal $<

gfx/bin/snake.cpal: gfx/png/snake2.png gfx/bin/
	rgbgfx -v -C -p $@ $<

gfx/bin/statusbar.1bpp: gfx/png/statusbar.png gfx/bin/
	rgbgfx -v -d 1 -o $@ $<

gfx/bin/title.1bpp gfx/bin/title.tilemap: gfx/png/title.png gfx/bin/
	rgbgfx -v -d 1 -o gfx/bin/title.1bpp $< -t gfx/bin/title.tilemap -u

obj/%.o: code/%.sm83 $(ASM_REQS) $(GFX_REQS) obj/
	rgbasm ${ASM_FLAGS} -o $@ $<

bin/${BIN_NAME}.gb: $(LINK_REQS) bin/
	rgblink ${LINK_FLAGS} -m bin/${BIN_NAME}.map -n bin/${BIN_NAME}.sym -o $@ obj/*.o
	rgbfix ${FIX_FLAGS} $@
