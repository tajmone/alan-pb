; "macros.pbi" v0.1.0 | 2022/01/25 | PureBASIC 5.73 LTS | ALAN 3.0beta8
; ------------------------------------------------------------------------------
; Some useful shared macros to slim down code size and improve its readability.
; ------------------------------------------------------------------------------

Macro HexAword(val)
  "$" + RSet(Hex(val, #PB_Long), 8, "0")
EndMacro
