; "mod_a3c.pbi" v0.2.0 | 2022/01/29 | PureBASIC 5.73 LTS | ALAN 3.0beta8
; ------------------------------------------------------------------------------
; * Checks if an '.a3c' file is a valid storyfile:
;   * File Exists? Minimum size met?
; * Load entire storyfile into memory:
;   * Does it start with the 'ALAN' tag?
; * Reverse AWords in Header section.
;   * Was it compiler with ALAN >= 3.0beta2?
;   * Validate CRC of ACode section.
; * Extracts and share the ALAN compiler version used.
; ------------------------------------------------------------------------------

DeclareModule a3c
  ;-/// Public Procedures Declarations
  Declare OpenStoryfile(a3cFName.s)
  ;-/// Public Data
  Structure StoryFileInfo
    FilePath.s
    FileSize.q
    CompilerVer.s
    UID.l
    IFID.s
  EndStructure

  SFInfo.StoryFileInfo

EndDeclareModule

Module a3c
  XIncludeFile "macros.pbi"
  XIncludeFile "ACodeHeader.pbi"

  ;-/// Private Procedures Declarations
  Declare.i CalculateCRC(*memPointer, memSzAWords.i)
  Declare.i ValidateACodeCRC()
  ; Endianess Handling:
  Declare   ReverseAword(*Aword.Long)
  Declare   ReverseHeader(*header.ACodeHeader)
  ; Compiler Version:
  Declare.s GetAlanVersionString()
  Declare.i Correction()
  Declare.i Is3_0Alpha()
  Declare.i Is3_0Beta()
  Declare.i IsPreBeta2()
  ; Info Dumping:
  Declare   DumpHeaderHex(*header)

  ;-/// Private Data
  *SFHeader.ACodeHeader

  Enumeration file_handles
    #a3cFile
  EndEnumeration

  *a3cMem = #NUL

  ;-/// Public Procedures
  Procedure OpenStoryfile(a3cFName.s)
    ; ------------------------------------------------
    ; Attempt to open and validate an '.a3' storyfile.
    ; ------------------------------------------------
    Shared *SFHeader, SFInfo, *a3cMem
    SFInfo\FileSize = FileSize(a3cFName)
    Select SFInfo
      Case -1
        ConsoleError("File not found: " + a3cFName)
        ProcedureReturn #False
      Case -2
        ConsoleError("File is a directory: " + a3cFName)
        ProcedureReturn #False
    EndSelect
    If SFInfo\FileSize < #szHeader
      ConsoleError("File is too small: " + a3cFName)
      ProcedureReturn #False
    EndIf
    SFInfo\FilePath = a3cFName

    If Not ReadFile(#a3cFile, a3cFName, #PB_File_SharedRead | #PB_Ascii)
      ConsoleError("Couldn't open file: " + a3cFName)
      ProcedureReturn #False
    EndIf

    ;- Allocate memory
    ;  ===============
    *a3cMem = AllocateMemory(SFInfo\FileSize)
    If Not *a3cMem
      ConsoleError("Unable to allocate memory.")
      ProcedureReturn #False
    EndIf

    ;- Read ACodeHeader into memory
    ;  ============================
    res = ReadData(#a3cFile, *a3cMem, SFInfo\FileSize)
    CloseFile(#a3cFile)
    If Not res
      ConsoleError("Couldn't open file: " + a3cFName)
      ProcedureReturn #False
    ElseIf res <> SFInfo\FileSize
      ConsoleError("WARNING: Expected " + SFInfo\FileSize +
                   " bytes, but read " + Str(res) + " instead!")
      ProcedureReturn #False
    EndIf
    *SFHeader = *a3cMem

    ;- Check that file starts with ALAN tag:
    If PeekS(@*SFHeader\tag, 4, #PB_Ascii) <> "ALAN"
      ConsoleError("File is not an ALAN storyfile: " + a3cFName)
      ProcedureReturn #False
    EndIf

    ;- Reverse ACodeHeader endianess
    ;  =============================
    ; PrintN("Header before reversing:")
    ; DumpHeaderHex(@*SFHeader)
    ReverseHeader(*SFHeader)
    ; PrintN("Header after reversing:")
    ; DumpHeaderHex(@*SFHeader)

    ;- Get Adventure compiler version
    SFInfo\CompilerVer = GetAlanVersionString()

    ;- Check version compatibility
    ;  ===========================
    ; Adventures created with ALAN < 3.0beta2 are not (yet) supported:
    If IsPreBeta2()
      ConsoleError("Unsupported compiler version: " + SFInfo\CompilerVer)
      ProcedureReturn #False
    EndIf

    ;- Validate CRC of ACode section
    ;  =============================
    ; This needs to be done before initializing the ACode section
    ; (i.e. adjusting endianess) since the CRC is calculated on the
    ; raw '.a3c' file, as is.
    If Not ValidateACodeCRC()
      ProcedureReturn #False
    EndIf

    ;-----------------------
    ProcedureReturn #True
  EndProcedure

  ;-/// Private Procedures

  Procedure.i CalculateCRC(*memPointer, memSzAWords.i)
    ; ------------------------------------------------------
    ; Calculate the checksum of the memory range starting at
    ; *memPointer, with size memSzAWords (number of AWords).
    ; ------------------------------------------------------
    crc.i = 0
    For i = 0 To memSzAWords - 1
      crc + (PeekL(*memPointer) & $FF)
      crc + ((PeekL(*memPointer) >> 8) & $FF)
      crc + ((PeekL(*memPointer) >> 16) & $FF)
      crc + ((PeekL(*memPointer) >> 24) & $FF)
      *memPointer + #szAword
    Next
    ProcedureReturn crc
  EndProcedure

  Procedure.i ValidateACodeCRC()
    ; --------------------------------------------------------
    ; Validate the checksum of the ACode section, which begins
    ; at the end of the Header section and ends at the offset
    ; stored in ACodeHeader.size (expressed in AWords).
    ; --------------------------------------------------------
    Shared *SFHeader, *a3cMem
    With *SFHeader
      *ACodeStart = *a3cMem + #szHeader
      ACodeSize = (\size & $FFFFFFFF) - (#szHeader/4)
      crcExpected.i = \acdcrc & $FFFFFFFF
      crcFound.i = CalculateCRC(*ACodeStart, ACodeSize)
      If crcFound <> crcExpected
        ConsoleError("Checksum error in ACode section: 0x" +
                     Hex(crcExpected, #PB_Long) + " instead of 0x" +
                     Hex(crcFound, #PB_Long) + ".")
        ProcedureReturn #False
      Else
        ProcedureReturn #True
      EndIf
    EndWith
  EndProcedure

  ;-// Endianess Handling Procedures

  Procedure ReverseAword(*Aword.Long)
    ; TODO: Check memory bounds?
    ; if (w < &memory[0] || w > &memory[memorySize])
    ;   syserr("Reversing address outside of memory");
    *Aword\l = ((((*Aword\l)&$FF)<<24)|
                (((*Aword\l)&$FF00)<<8)|
                (((*Aword\l)>>8)&$FF00)|
                (((*Aword\l)>>24)&$FF))
  EndProcedure

  Procedure ReverseHeader(*header.ACodeHeader)
    ; ----------------------------------------------------------------
    ; Reverse all AWords in the memorized storyfile Header section,
    ; except the ALAN tag and the version marking, which are sequences
    ; of four ASCII chars.
    ; ----------------------------------------------------------------
    For i = SizeOf(long) * 2 To #szHeader Step SizeOf(long)
      ReverseAword(*header + i)
    Next
  EndProcedure

  ;- // Compiler Version Procedures

  Procedure.s GetAlanVersionString()
    ; --------------------------------------------------------------
    ; Extract the adventure compiler version marking from the Header
    ; and return it as a string (UCS-2 format).
    ; --------------------------------------------------------------
    Shared *SFHeader
    With *SFHeader
      a3cVer.s = StrU(\version[0]) + "." +  ; -> Version
                 StrU(\version[1])          ; -> Revision
      Select \version[3] & $FF              ; -> State
        Case 0
          a3cVer + "." ; Stable
        Case 'd'
          a3cVer + "dev"
        Case 'a'
          a3cVer + "alpha"
        Case 'b'
          a3cVer + "beta"
        Default ; Fallback for handling unexpected values...
          a3cVer + StrU(\version[3])
      EndSelect
      a3cVer + StrU(\version[2])            ; -> Correction
    EndWith
    ProcedureReturn a3cVer
  EndProcedure

  Procedure.i Correction()
    ; --------------------------------------------------
    ; Extract and return the Correction segment from the
    ; ALAN compiler version marking in Header.version[].
    ; --------------------------------------------------
    Shared *SFHeader
    ProcedureReturn *SFHeader\version[2] & $FF
  EndProcedure

  Procedure.i Is3_0Alpha()
    ; ALAN 3.0alpha (any correction).
    ; ----------------------------------------------
    Shared *SFHeader
    With *SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'a')
    EndWith
  EndProcedure

  Procedure.i Is3_0Beta()
    ; ----------------------------------------------
    ; Check whether the adventure was compiled using
    ; ALAN 3.0beta (any correction).
    ; ----------------------------------------------
    Shared *SFHeader
    With *SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'b')
    EndWith
  EndProcedure

  Procedure.i IsPreBeta2()
    ; ----------------------------------------------
    ; Check whether the adventure was compiled using
    ; ALAN < 3.0beta2.
    ; ----------------------------------------------
    ProcedureReturn Bool(Is3_0Alpha() Or
                         (Is3_0Beta() And
                          Correction() <= 1))
  EndProcedure

  ;- Info Dumping Procedures

  Procedure DumpHeaderHex(*header.Long)
    PrintN("--- ACodeHeader --------------------------")
    For i = 1 To #szHeader/SizeOf(long)
      Print(HexAword(*header\l))
      c + 1
      If c = 4
        Print(#LF$)
        c = 0
      Else
        Print("  ")
      EndIf
      *header + 4
    Next
    PrintN(#LF$ + "------------------------------------------")
  EndProcedure

EndModule

; /// EOF ///
