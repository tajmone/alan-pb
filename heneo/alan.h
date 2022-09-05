/* ============================================
   Alan v0.0.13 (2019/05/08) by Tristano Ajmone
   --------------------------------------------
   Structure Definition for Hex Editor Neo 6.42
   Structure Viewer v 6.31
   --------------------------------------------
   Associated extensions: .+?\.a3c$
   --------------------------------------------
   Main Storyfile Structures:
   - ACodeHeader
   ============================================*/



// Alan uses Big Endianess:
#pragma byte_order(BigEndian)

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   For now, we'll use the native header for Alan types so that the definition
   works out of the box; but we'll dispose of it in the end.
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
#include "alan-types.h"

/*==============================================================================
                                Alan Version Info
===============================================================================*/

function ReleaseType( ReleaseByte )
{
   switch ( ReleaseByte )
   {
      case  0:  return ".";
      case 'd': return "dev";
      case 'a': return "alpha";
      case 'b': return "beta";
      // not sure how to handle other values:
      default:  return "?"; // Unknown release type!
      /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         in original code it would just printf the original char as '%s'
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
   }
}
// ---------------------------
// Alan Version Marking Struct
// ---------------------------
// In the form "X.Y<STATE>Z"
// The bytes are (in order):
// - version
// - revision
// - correction
// - state

[display(format("{0}.{1}{2}{3}", VERSION, REVISION, ReleaseType(STATE), CORRECTION))]
struct ALAN_VERSION {
   // cf. "main.c" (L 197) setupHeader()
   [format("b10")]
   unsigned char  VERSION;

   [format("b10"), noautohide]
   unsigned char  REVISION;

   [format("b10")]
   unsigned char  CORRECTION;

   [description("Release state")]
   unsigned char  STATE;

};
// --------------------------
// Alan Compiler Version Info
// --------------------------
[display(format("{0} {1}.{2}{3}{4}",
   string(tag), Version.VERSION, Version.REVISION,
   ReleaseType(Version.STATE), Version.CORRECTION))]
struct ALAN_INFO {

   // "ALAN" Magic tag/identifier
   [description("Identifier for ALAN .a3c files.")]
   char tag[4];
   $assert( string(tag) == "ALAN", "Not an Alan game file, does not start with \"ALAN\"!",1 );

   // ALAN Compiler version.
   [description("Compiler version.")]
   ALAN_VERSION Version;
};


/*==============================================================================
                                  ACode Header
===============================================================================*/
struct ACodeHeader {

   // ========================
   // Important Adventure Info
   // ========================
   ALAN_INFO AlanVersion;   // Alan compiler version

   [description(         "Storyfile unique ID (timestamp) to match saved games.")]
   Aword uid;           // Unique id of the compiled game

   // TODO: Not sure what this size refers to. It's not the file.
   [description(         "Size of ACD-file in Awords")]
   Aword size;              // Size of ACD-file in Awords

   // =====================
   // ALAN Compiler Options
   // =====================

   [description(         "Is the text packed and encoded?")]
   Abool pack;               /* Is the text packed and encoded ? */
   [description(         "Offset to string data in game file")]
   Aword stringOffset;       /* Offset to string data in game file */
   [description(         "Length of a displayed page")]
   Aword pageLength;         /* Length of a displayed page */

   [description(         "Width of a displayed page")]
   Aword pageWidth;          /* and width */

   [description(         "Option: debug")]
   Aword debug;              /* Option: debug */

   // ===============
   // Data structures
   // ===============

   Aaddr classTableAddress;
   Aword classMax;
   Aword entityClassId;
   Aword thingClassId;
   Aword objectClassId;
   Aword locationClassId;
   Aword actorClassId;
   Aword literalClassId;
   Aword integerClassId;
   Aword stringClassId;
   Aaddr instanceTableAddress;   /* Instance table */
   [description(         "Highest number of an instance")]
   Aword instanceMax;          /* Highest number of an instance */
   [description(         "The hero instance code (id)")]
   Aword theHero;              /* The hero instance code (id) */
   Aaddr containerTableAddress;
   Aword containerMax;
   Aaddr scriptTableAddress;
   Aword scriptMax;
   Aaddr eventTableAddress;
   Aword eventMax;
   Aaddr syntaxTableAddress;
   Aaddr parameterMapAddress;
   Aword syntaxMax;
   Aaddr dictionary;
   Aaddr verbTableAddress;
   Aaddr ruleTableAddress;
   Aaddr messageTableAddress;

   // =============
   // Miscellaneous
   // =============
   [description(         "Size of attribute data area in Awords")]
   Aint attributesAreaSize;   /* Size of attribute data area in Awords */
   [description(         "Maximum number of parameters in any syntax")]
   Aint maxParameters;     /* Maximum number of parameters in any syntax */
   [description(         "String init table address")]
   Aaddr stringInitTable;  /* String init table address */
   [description(         "Set init table address")]
   Aaddr setInitTable;     /* Set init table address */
   [description(         "Address to Start code")]
   Aaddr start;      /* Address to Start code */
   [description(         "Maximum score")]
   Aword maximumScore;     /* Maximum score */
   [description(         "Score table")]
   Aaddr scores;     /* Score table */
   [description(         "Max index into scores table")]
   Aint scoreCount;     /* Max index into scores table */
   [description(         "Table of fpos/len for source filenames")]
   Aaddr sourceFileTable;  /* Table of fpos/len for source filenames */
   [description(         "Table of available source lines to break on")]
   Aaddr sourceLineTable;  /* Table of available source lines to break on */
   [description(         "Address to Char freq's for coding")]
   Aaddr freq;       /* Address to Char freq's for coding */
   [description(         "Checksum for acd code (excl. hdr)")]
   Aword acdcrc;     /* Checksum for acd code (excl. hdr) */
   [description(         "Checksum for text data file")]
   Aword txtcrc;     /* Checksum for text data file */
   [description(         "Address to IFIDS")]
   Aaddr ifids;      /* Address to IFIDS */
   Aaddr prompt;
};


/*******************************************************************************
*                                                                              *
*                                ALAN Storyfile                                *
*                                                                              *
********************************************************************************
The actual public structure.
------------------------------------------------------------------------------*/

public struct a3c
{
   [description("Storyfile header")]
   ACodeHeader ACodeHeader;
};
