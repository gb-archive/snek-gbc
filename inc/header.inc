	; extended header, this file can be safely removed, i just wanted build date burned onto ROM

	db "DATE  {02u:__UTC_DAY__}-{02u:__UTC_MONTH__}-{04u:__UTC_YEAR__}" ; build date
	db "TIME    {02u:__UTC_HOUR__}:{02u:__UTC_MINUTE__}:{02u:__UTC_SECOND__}" ; build time
	db "RGBDS{11s:__RGBDS_VERSION__}" ; rgbds version used for the build
	
	; the reason this is a separate file? just in case i edit it later