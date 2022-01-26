# ALAN Storyfile Parser

WIP PureBasic module to read, initialize and validate ALAN&nbsp;3 `.a3c` storyfiles.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Directory Contents](#directory-contents)
- [Status](#status)

<!-- /MarkdownTOC -->

-----

# Directory Contents

- [`a3cinfo.pb`][a3cinfo.pb] — demo console app.
- [`ACodeHeader.pbi`][ACodeHeader.pbi] — a3c header definition.
- [`macros.pbi`][macros.pbi] — shared macro helpers.
- [`mod_a3c.pbi`][mod_a3c.pbi] — module for loading and initializing `.a3c` files.

# Status

The code is still in its early stages, and lacks Rake automation and proper documentation at the moment.

Ultimately, this folder will contain the modules to properly manage ALAN storyfiles (`.a3c`), i.e. load them into memory, validate them, and extract (dump) info.

The `a3cinfo` will be a demo console application to inspect storyfiles and dump info about their internal data.

The next step will be to implement the code to actually run an adventure by implementing the Amachine, and manage adventures' media resource files (`.a3r`), which will be handled by separate modules in other folders.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

<!-- project files & folders -->

[a3cinfo.pb]: ./a3cinfo.pb "View PureBasic source"
[ACodeHeader.pbi]: ./ACodeHeader.pbi "View PureBasic source"
[macros.pbi]: ./macros.pbi "View PureBasic source"
[mod_a3c.pbi]: ./mod_a3c.pbi "View PureBasic source"


<!-- EOF -->
