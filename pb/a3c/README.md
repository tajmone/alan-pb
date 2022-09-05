# ALAN Storyfile Parser

[![PureBasic Version][pb badge]][PureBasic]&nbsp;
[![License][license badge]][LICENSE]

WIP PureBasic module [`mod_a3c.pbi`][mod_a3c.pbi] to read, initialize and validate ALAN&nbsp;3 `.a3c` storyfiles.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Directory Contents](#directory-contents)
- [Status](#status)

<!-- /MarkdownTOC -->

-----

# Directory Contents

- [`a3cinfo.pb`][a3cinfo.pb] — demo console app.
- [`mod_a3c.pbi`][mod_a3c.pbi] — module for loading and initializing `.a3c` files.
    + [`acode-datatypes.pbi`][acode-datatypes.pbi] — a3c header and data types definitions.
    + [`helpers.pbi`][helpers.pbi] — shared macro and constants helpers.

# Status

The code is still in its early stages, and lacks Rake automation and proper documentation at the moment.

Ultimately, this folder will contain the modules to properly manage ALAN storyfiles (`.a3c`), i.e. load them into memory, validate them, and extract (dump) info.

The `a3cinfo` will be a demo console application to inspect storyfiles and dump info about their internal data, similar to the [dumpacd] utility included in the [ALAN source repository], which is currently broken.

The next step will be to implement the code to actually run an adventure by implementing the Amachine, and manage adventures' media resource files (`.a3r`), which will be handled by separate modules in other folders.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[ALAN source repository]: https://github.com/alan-if/alan "Visit ALAN repository at GitHub.com"
[dumpacd]: https://github.com/alan-if/alan/blob/master/interpreter/dumpacd.c "View upstream C source of the 'dumpacd' tool at ALAN repository"

<!-- PureBasic -->

[PureBasic]: https://www.purebasic.com "Visit the PureBasic website"

<!-- project files & folders -->

[a3cinfo.pb]: ./a3cinfo.pb "View PureBasic source"
[acode-datatypes.pbi]: ./acode-datatypes.pbi "View PureBasic source"
[helpers.pbi]: ./helpers.pbi "View PureBasic source"
[mod_a3c.pbi]: ./mod_a3c.pbi "View PureBasic source"

[LICENSE]: ./LICENSE "View MIT License"

<!-- badges -->

[pb badge]: https://img.shields.io/badge/PureBasic-5.73-yellow
[license badge]: https://img.shields.io/badge/license-MIT-blue

<!-- EOF -->
