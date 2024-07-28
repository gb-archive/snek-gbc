INCLUDE "inc/hardware.inc"

SECTION "vblank", ROM0
VBlank::
	; popslide the statusbar
	ld hl, wGameTilemap.statusbar
	ld de, _SCRN0+(SCRN_VX_B*16)
	ld a, (wGameTilemap.end - wGameTilemap.statusbar) >> 4
	call Popslide
	; fetch the buffer length
	ld hl, wVBuffer.size
	ld b, [hl]
	dec h
	; abort if zero
	xor a
	cp b
	jr z, .return
	; fetch the requested update
	.loop
	ld a, [hl+] ; load address, little-endian
	ld e, a
	ld a, [hl+]
	ld d, a
	ld a, [hl+] ; load value
	ld [de], a
	dec b ; repeat for all queued bytes
	jr nz, .loop
	; return
	.return
	xor a
	ld [wVBuffer.size], a
	pop hl
	pop de
	pop bc
	pop af
	reti

VBufferPush:: ; hl - dest, a - value, clobbers bc, de
	di
	ld c, a ; store for later
	ld a, [wVBuffer.size] ; fetch next slot
	ld b, a
	add b ; mul by 3
	add b
	ld e, a
	ld d, HIGH(wVBuffer)
	ld a, l ; store lo
	ld [de], a
	inc e
	ld a, h ; store hi
	ld [de], a
	inc e
	ld a, c ; store value
	ld [de], a
	ld hl, wVBuffer.size
	inc [hl]
	reti

SECTION "vbuffer", WRAM0, ALIGN[8]
wVBuffer:: ds 256 ; FIFO for VRAM updates: lo dest, hi dest, value
wVBuffer.size:: ds 1