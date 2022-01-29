; "a3cinfo.pb" v0.2.0 | 2022/01/29 | PureBASIC 5.73 LTS | ALAN 3.0beta8
; ******************************************************************************
; *                                                                            *
; *                        ALAN Story File Info-Dumper                         *
; *                                                                            *
; *                             by Tristano Ajmone                             *
; *                                                                            *
; ******************************************************************************
; !!! WIP !!! Doesn't do much right now besides:
;   * Checking if an '.a3c' file is a valid storyfile.
;   * Extracting the ALAN compiler version used.
;
; Eventually, will parse an Alan compiled adventure and print useful info.
; ------------------------------------------------------------------------------

; TODO: CLI options!
#PATH2DEMOS$ = "../../adventures/demos/"
#STORY_FILE$ = #PATH2DEMOS$ + "advent.a3c"

XIncludeFile "mod_a3c.pbi"

ExitCode = 0
OpenConsole()

If Not a3c::OpenStoryfile(#STORY_FILE$)
  ExitCode = 1
  Goto quit_app
EndIf

; PrintN("Validation passed.")
With a3c::SFInfo
  PrintN("Adventure compiled using ALAN " + \CompilerVer)
EndWith


quit_app:
CloseConsole()
End ExitCode

; /// EOF ///
