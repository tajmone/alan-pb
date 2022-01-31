; "helpers.pbi" v0.1.0 | 2022/01/31 | PureBASIC 5.73 LTS | ALAN 3.0beta8
; ------------------------------------------------------------------------------
; Some useful shared macros and constants to slim down code size and improve its
; readability.
; ------------------------------------------------------------------------------

#szAword = SizeOf(Long)
#szHeader = SizeOf(ACodeHeader)

Macro HexAword(val)
  "$" + RSet(Hex(val, #PB_Long), 8, "0")
EndMacro
