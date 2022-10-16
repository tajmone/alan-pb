; "mod_a3c.pbi" v0.2.1 | 2022/10/19 | PureBASIC 6.00 LTS | ALAN 3.0beta8
;{------------------------------------------------------------------------------
; Load a storyfile, fix endianess and validate.
; ------------------------------------------------------------------------------
; Currently supported tasks:
;   * Checks if an '.a3c' file is a valid storyfile:
;     * File Exists? Minimum size met?
;   * Load entire storyfile into memory:
;     * Does it start with the 'ALAN' tag?
;   * Reverse AWords in Header section.
;     * Was it compiled with ALAN >= 3.0beta2?
;     * Validate CRC of ACode section.
;   * Extracts and share the ALAN compiler version used.
;
; Work-in-progress tasks:
;   [ ] Reverse ACode:                      --> ReverseACode()
;       [x] aux-procs.                      --> AlreadyDone()
;       [x] aux-procs.                      --> IsEndOfArray()
;       [x] aux-procs.                      --> ReverseTable()
;       [x] Reverse dictionary table.       --> ReverseDictionary()
;       [ ] Reverse syntax table.           --> ReverseSyntaxTable()
;       [ ] Reverse parameters table.       --> ReverseParameterTable()
;       [ ] Reverse verbs table.            --> ReverseVerbs()
;       [ ] Reverse classes table.          --> ReverseClasses()
;       [ ] Reverse instances table.        --> ReverseInstances()
;       [ ] Reverse scripts table.          --> ReverseScrs()
;       [ ] Reverse containers table.       --> ReverseContainers()
;       [ ] Reverse events table.           --> ReverseEvts()
;       [ ] Reverse rules table.            --> ReverseRuls()
;       [ ] Reverse string init table.      --> ReverseTable(*SFHeader\stringInitTable)
;       [ ] Reverse set init table.         --> ReverseSetInitTable()
;       [ ] Reverse source file table.      --> ReverseTable(*SFHeader\sourceFileTable)
;       [ ] Reverse source line table.      --> ReverseTable(*SFHeader\sourceLineTable)
;       [ ] Reverse statements prompt.      --> ReverseStms()
;       [ ] Reverse statements start.       --> ReverseStms()
;       [ ] Reverse messages table.         --> ReverseMsgs()
;       [ ] Reverse scores table.           --> ReverseTable(*SFHeader\scores)
;       [ ] Reverse frequency table.        --> ReverseTable(*SFHeader\freq)
;}------------------------------------------------------------------------------

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
  XIncludeFile "acode-datatypes.pbi"
  XIncludeFile "helpers.pbi"

  ;-/// Private Procedures Declarations
  Declare.i CalculateCRC(*memPointer, memSzAWords.i)
  Declare.i ValidateACodeCRC()
  ; Endianess Handling:
  Declare   ReverseAword(*Aword.Long)
  Declare   ReverseTable(*table, elementSizeInBytes)
  Declare   ReverseHeader(*header.ACodeHeader)
  Declare   ReverseACode()
  Declare   ReverseDictionary(Aaddr.l)
  Declare.i AlreadyDone(Aaddr.l)
  Declare.i IsEndOfArray(*mempos)
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

  NewList AddressesDone.l() ; Aaddr (u32)

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

    ;- Reverse ACode section endianess
    ;  ===============================
    ReverseACode()
    ;-----------------------
    ProcedureReturn #True
  EndProcedure

  ;-/// Private Procedures

  ; ------------------------------------------------------
  ; Calculate the checksum of the memory range starting at
  ; *memPointer, with size memSzAWords (number of AWords).
  ; ------------------------------------------------------
  Procedure.i CalculateCRC(*memPointer, memSzAWords.i)
    crc.i = 0
    For i = 1 To memSzAWords
      crc + (PeekL(*memPointer) & $FF)
      crc + ((PeekL(*memPointer) >> 8) & $FF)
      crc + ((PeekL(*memPointer) >> 16) & $FF)
      crc + ((PeekL(*memPointer) >> 24) & $FF)
      *memPointer + #szAword
    Next
    ProcedureReturn crc
  EndProcedure

  ; --------------------------------------------------------
  ; Validate the checksum of the ACode section, which begins
  ; at the end of the Header section and ends at the offset
  ; stored in ACodeHeader.size (expressed in AWords).
  ; --------------------------------------------------------
  Procedure.i ValidateACodeCRC()
    Shared *SFHeader, *a3cMem
    With *SFHeader
      *ACodeStart = *a3cMem + #szHeader
      ACodeSize = (u32(\size)) - (#szHeader/4)
      crcExpected.i = u32(\acdcrc)
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
    Shared *a3cMem
    ; WIP: Check memory bounds of ReverseAword() param
    If *Aword < *a3cMem Or *Aword > (*a3cMem + MemorySize(*a3cMem))
      ; TODO: Not properly tested! Is the above formula for upper bound pointer correct?
      ConsoleError("*** ReverseAword(): out of bounds parameter ***")
      End 1 ; FIXME: use Abort procedure instead!
    EndIf
    ;; if (w < &memory[0] || w > &memory[memorySize])
    ;;   syserr("Reversing address outside of memory");

    *Aword\l = ((((*Aword\l)&$FF)<<24)|
                (((*Aword\l)&$FF00)<<8)|
                (((*Aword\l)>>8)&$FF00)|
                (((*Aword\l)>>24)&$FF))
  EndProcedure

  ; ---------------------------------------------------------------
  ; Given a pointer to the start of a table in the ACode section,
  ; iterate through all its records reversing its Awords endianess.
  ; A table ends (or is empty) when its points at #EOF (-1).
  ; ---------------------------------------------------------------
  Procedure ReverseTable(*table, elementSizeInBytes)
    ; *table -> pointer to beginning of a table in *a3cMem
    If elementSizeInBytes < #szAword Or
       elementSizeInBytes % #szAword
      ; TODO: syserr() to Abort with Error!
      ConsoleError("***Wrong size in 'ReverseTable()' ***")
      End 1 ; FIXME: use Abort procedure instead!
    EndIf
    If Not *table
      ProcedureReturn
    EndIf

    While Not IsEndOfArray(*table)
      For i = 1 To (elementSizeInBytes/#szAword)
        ReverseAword(*table)
        *table + #szAword
      Next
    Wend
  EndProcedure

  ; ----------------------------------------------------------------
  ; Reverse all AWords in the memorized storyfile Header section,
  ; except the ALAN tag and the version marking, which are sequences
  ; of four ASCII chars.
  ; ----------------------------------------------------------------
  Procedure ReverseHeader(*header.ACodeHeader)
    For i = SizeOf(long) * 2 To #szHeader Step SizeOf(long)
      ReverseAword(*header + i)
    Next
  EndProcedure

  ; ---------------------------------------------------------------
  ; Traverse all the data structures of the memorized ACode section
  ; and reverse byte order of all integers.
  ; SEE: "reverse.c" -> reverseNative()
  ; ---------------------------------------------------------------
  Procedure ReverseACode() ; WIP: Missing procedures
    Shared *SFHeader
    ;; memorySize = header->size;
    ;; reverseDictionary(header->dictionary);
    ReverseDictionary(*SFHeader\dictionary)
  EndProcedure

  ;; reverseSyntaxTable(header->syntaxTableAddress, header->version);
  ;; if (header->debug && !isPreBeta3(header->version))
  ;;     reverseParameterNames(header->parameterMapAddress);
  ;; reverseParameterTable(header->parameterMapAddress);
  ;; reverseVerbs(header->verbTableAddress);
  ;; reverseClasses(header->classTableAddress);
  ;; reverseInstances(header->instanceTableAddress);
  ;; if (header->debug && !isPreBeta3(header->version))
  ;;     reverseInstanceIdTable(header);
  ;; reverseScrs(header->scriptTableAddress);
  ;; reverseContainers(header->containerTableAddress);
  ;; reverseEvts(header->eventTableAddress);
  ;; reverseRuls(header->ruleTableAddress);
  ;; reverseTable(header->stringInitTable, sizeof(StringInitEntry));
  ;; reverseSetInitTable(header->setInitTable);
  ;; reverseTable(header->sourceFileTable, sizeof(SourceFileEntry));
  ;; reverseTable(header->sourceLineTable, sizeof(SourceLineEntry));
  ;; reverseStms(header->prompt);
  ;; reverseStms(header->start);
  ;; reverseMsgs(header->messageTableAddress);
  ;; if (!isPreBeta7(version))
  ;;     /* We can't find the IFID:s in pre-beta7 because of a bug in compiler */
  ;;     reverseIfids(header->ifids);
  ;;
  ;; reverseTable(header->scores, sizeof(Aword));
  ;; reverseTable(header->freq, sizeof(Aword));

  ; ---------------------------------------------------------------
  ; Fix endianess of *SFHeader\dictionary table and its references.
  ; ---------------------------------------------------------------
  Procedure ReverseDictionary(Aaddr.l)
    Shared *a3cMem, AddressesDone()
    If Not Aaddr Or AlreadyDone(Aaddr)
      ProcedureReturn
    EndIf
    *e.DictionaryEntry = AaddrToPointer(Aaddr)
    If Not IsEndOfArray(*e)
      ; Reverse all Dict entries...
      ReverseTable(*e, SizeOf(DictionaryEntry))
      ; Reverse all Dict->fields tables...
      While Not IsEndOfArray(*e)
        If ((*e\classBits & #SYNONYM_BIT) = 0) ; Don't do this for Synonyms
          ReverseTable(AaddrToPointer(*e\adjectiveRefs), #szAword)
          ReverseTable(AaddrToPointer(*e\nounRefs), #szAword)
          ReverseTable(AaddrToPointer(*e\pronounRefs), #szAword)
        EndIf
        *e + SizeOf(DictionaryEntry)
      Wend
    EndIf

  EndProcedure

  ; -------------------------------------------------------------
  ; Check whether a given ACode Aaddr was already endian-reversed
  ; and if not add it to the list of done addresses.
  ; This is needed during ReverseACode() to avoid reversing more
  ; than once entries with multiple references.
  ; -------------------------------------------------------------
  Procedure.i AlreadyDone(Aaddr.l)
    ; TODO: Find better name for this proc.
    Shared AddressesDone()
    ; Was Aaddr already dealt with?
    ForEach AddressesDone()
      If AddressesDone() = Aaddr
        ProcedureReturn #True
      EndIf
    Next
    AddElement(AddressesDone())
    AddressesDone() = Aaddr
  EndProcedure

  ; -------------------------------------------------------------
  ; Check whether an ACode pointer points to #EOF, which delimits
  ; the end of a sequence of records (or the lack thereof).
  ; -------------------------------------------------------------
  Procedure.i IsEndOfArray(*mempos.Long)
    ; NOTE: EOF = -1 (defined in C, but not in PB)
    ProcedureReturn Bool(*mempos\l = #EOF)
  EndProcedure


  ;- // Compiler Version Procedures

  ; --------------------------------------------------------------
  ; Extract the adventure compiler version marking from the Header
  ; and return it as a string (UCS-2 format).
  ; --------------------------------------------------------------
  Procedure.s GetAlanVersionString()
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

  ; --------------------------------------------------
  ; Extract and return the Correction segment from the
  ; ALAN compiler version marking in Header.version[].
  ; --------------------------------------------------
  Procedure.i Correction()
    Shared *SFHeader
    ProcedureReturn *SFHeader\version[2] & $FF
  EndProcedure

  ; ----------------------------------------------
  ; Check whether the adventure was compiled using
  ; ALAN 3.0alpha (any correction).
  ; ----------------------------------------------
  Procedure.i Is3_0Alpha()
    Shared *SFHeader
    With *SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'a')
    EndWith
  EndProcedure

  ; ----------------------------------------------
  ; Check whether the adventure was compiled using
  ; ALAN 3.0beta (any correction).
  ; ----------------------------------------------
  Procedure.i Is3_0Beta()
    Shared *SFHeader
    With *SFHeader
      ProcedureReturn Bool((\version[0] & $FF) = 3 And
                           (\version[1] & $FF = 0) And
                           (\version[3] & $FF) = 'b')
    EndWith
  EndProcedure

  ; ----------------------------------------------
  ; Check whether the adventure was compiled using
  ; ALAN < 3.0beta2.
  ; ----------------------------------------------
  Procedure.i IsPreBeta2()
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
