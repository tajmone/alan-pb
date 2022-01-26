; "mod_a3c.pbi" v0.1.1 | 2022/01/26 | PureBASIC 5.73 LTS | ALAN 3.0beta8
; ------------------------------------------------------------------------------
; * Checks if an '.a3c' file is a valid storyfile:
;   * File Exists?
;   * Does it start with the 'ALAN' tag?
;   * Was it compiler with ALAN >= 3.0beta2?
; * Extracts the ALAN compiler version used.
; ------------------------------------------------------------------------------

DeclareModule a3c
  ;-/// Public Procedures Declarations
  Declare OpenStoryfile(a3cFName.s)
  ;-/// Public Data
  Structure StoryFileInfo
    FilePath.s
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
  SFHeader.ACodeHeader

  Enumeration file_handles
    #a3cFile
  EndEnumeration

  ;-/// Public Procedures
  Procedure OpenStoryfile(a3cFName.s)
    ; Attempts to open and validate an ".a3c" file
    Shared SFHeader, SFInfo
    Select FileSize(a3cFName)
      Case -1
        ConsoleError("File not found: " + a3cFName)
        ProcedureReturn #False
      Case -2
        ConsoleError("File is a directory: " + a3cFName)
        ProcedureReturn #False
        ; TODO: If file-size < size of Header Struct then it's malformed!
      Default
        SFInfo\FilePath = a3cFName
    EndSelect

    If Not ReadFile(#a3cFile, a3cFName, #PB_File_SharedRead | #PB_Ascii)
      ConsoleError("Couldn't open file: " + a3cFName)
      ProcedureReturn #False
    EndIf

    ;- Read ACodeHeader into memory
    FileSeek(#a3cFile, 0)
    res = ReadData(#a3cFile, @SFHeader, SizeOf(ACodeHeader))
    If Not res
      ConsoleError("Couldn't open file: " + a3cFName)
      ProcedureReturn #False
    ElseIf res < SizeOf(ACodeHeader)
      ConsoleError("File size too small: " + a3cFName)
      ProcedureReturn #False
    ElseIf res <> SizeOf(ACodeHeader)
      ConsoleError("WARNING: Expected " + Str(SizeOf(ACodeHeader)) +
                   " bytes, but read " + Str(res) + " instead!")
    EndIf
    ;- Reverse ACodeHeader Endiness
    ; PrintN("Header before reversing:")
    ; DumpHeaderHex(@SFHeader)
    ReverseHeader(@SFHeader)
    ; PrintN("Header after reversing:")
    ; DumpHeaderHex(@SFHeader)

    ;- Check that file starts with ALAN tag:
    If PeekS(@SFHeader\tag, 4, #PB_Ascii) <> "ALAN"
      ConsoleError("File is not an ALAN storyfile: " + a3cFName)
      ProcedureReturn #False
    EndIf

    ;- Get Adventure compiler version:
    SFInfo\CompilerVer = GetAlanVersionString()

    ;- Check version compatibility:
    ; Adventures created with ALAN < 3.0beta2 are not (yet) supported:
    If IsPreBeta2()
      ConsoleError("Unsupported compiler version: " + SFInfo\CompilerVer)
      ProcedureReturn #False
    EndIf

    ;-----------------------

    CloseFile(#a3cFile)
    ProcedureReturn #True
  EndProcedure

  ;-/// Private Procedures

  ;-// Endianess Handling Procedures

  Procedure ReverseAword(*Aword.Long)
    ; TODO: Check memory bounds.
    ; if (w < &memory[0] || w > &memory[memorySize])
    ;   syserr("Reversing address outside of memory");
    *Aword\l = ((((*Aword\l)&$FF)<<24)|
                (((*Aword\l)&$FF00)<<8)|
                (((*Aword\l)>>8)&$FF00)|
                (((*Aword\l)>>24)&$FF))
  EndProcedure

  Procedure ReverseHeader(*header.ACodeHeader)
    ; Reverse all words in the header except the tag and the version marking
    For i = SizeOf(long) * 2 To SizeOf(ACodeHeader) Step SizeOf(long)
      ReverseAword(*header + i)
    Next
  EndProcedure

  ;- // Compiler Version Procedures

  Procedure.s GetAlanVersionString()
    ; Converts adventure compiler version to string.
    Shared SFHeader
    With SFHeader
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
        Default
          a3cVer + StrU(\version[3]) ; (whatever that means)
      EndSelect
      a3cVer + StrU(\version[2])            ; -> Correction
    EndWith
    ProcedureReturn a3cVer
  EndProcedure

  Procedure.i Correction()
    ; Return Alan Version->Correction
    Shared SFHeader
    ProcedureReturn SFHeader\version[2] & $FF
  EndProcedure

  Procedure.i Is3_0Alpha()
    ; Check whether adventure was compiled with ALAN 3.0alpha (any correction)
    Shared SFHeader
    With SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'a')
    EndWith
  EndProcedure

  Procedure.i Is3_0Beta()
    ; Check whether adventure was compiled with ALAN 3.0beta (any correction)
    Shared SFHeader
    With SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'b')
    EndWith
  EndProcedure

  Procedure.i IsPreBeta2()
    ; Check whether adventure was compiled with ALAN < 3.0beta2
    ProcedureReturn Bool(Is3_0Alpha() Or
                         (Is3_0Beta() And Correction() <= 1))
  EndProcedure

  ;- Info Dumping Procedures

  Procedure DumpHeaderHex(*header.Long)
    PrintN("--- ACodeHeader --------------------------")
    For i = 1 To SizeOf(ACodeHeader)/SizeOf(long)
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
