; "helpers.pbi" v0.1.1 | 2022/10/19 | PureBASIC 6.00 LTS | ALAN 3.0beta8
; ------------------------------------------------------------------------------
; Some useful shared macros and constants to slim down code size and improve its
; readability.
; ------------------------------------------------------------------------------

; ==============================================================================
;-                                  Constants
; ==============================================================================

#EOF = -1 ; marks end-of-arrays in ACode data structures.

#szAword = SizeOf(Long)
#szHeader = SizeOf(ACodeHeader)

; ==============================================================================
;-                                    Macros
; ==============================================================================

; Cast unsigned 32-bit integer to signed 64-bit.
Macro u32(exp)
  (exp & $FFFFFFFF)
EndMacro

; Convert Aadr to memory pointer: i.e. Awords offset from *a3cMem
Macro AaddrToPointer(aadr)
  (*a3cMem + u32(aadr) * #szAword)
EndMacro

;- String formatting
;  =================

Macro HexAword(val)
  "$" + RSet(Hex(val, #PB_Long), 8, "0")
EndMacro

Macro HexPointer(ptr)
  "$" + RSet(Hex(ptr), SizeOf(ptr) * 2, "0")
EndMacro
