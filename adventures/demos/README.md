# Demo Adventures

Some third party ALAN IF v3 demo adventures for testing purposes.


-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Folder Contents](#folder-contents)
    - [Changes](#changes)
- [Building](#building)
- [Adding New Adventures](#adding-new-adventures)
- [Credits](#credits)
    - [Advent](#advent)
    - [Saviour](#saviour)

<!-- /MarkdownTOC -->

-----

# Folder Contents

This repository folder contains the following source adventures, and their multimedia assets:

- [`advent.alan`][advent.alan]
- [`cloak.alan`][cloak.alan]
- [`saviour.alan`][saviour.alan]
- [`saviour.png`][saviour.png]

## Changes

For the sake of code styles consistency, all ALAN sources were converted from ISO-8859-1 to UTF-8 with BOM, indented using spaces, and stripped of all trailing spaces.

For the sake of brevity, the _Advent_ source file was renamed from `adventV3.alan` to `advent.alan`.

In order to keep related assets grouped under same-named files, the original `logo.png` image from _Saviour_ was renamed to `saviour.png`, and its `Show` statement in `saviour.alan` (L&nbsp;1354) was adapted accordingly.

Besides these changes, which are merely aesthetic and organizational, the source code of the original adventures wasn't altered in any meaningful way.


# Building

    rake :demos

For testing this repository, we need that each adventure is compiled with and without the `-debug` and `-pack` options, in turn.

Therefore, the Rake task will compile each source adventure three times, invoking the ALAN compiler with different options, then rename the generated storyfiles (`.a3c`) and resource files (`.a3r`) according to the following convention:

- `<adventure>_DBG.a3c`/`.a3r` — compiler option `-debug`
- `<adventure>_PACK.a3c`/`.a3r` — compiler option `-pack`
- `<adventure>.a3c`/`.a3r` — no compiler options


# Adding New Adventures

Rake will auto-detect and handle any `*.alan` source found in this folder, so new source adventures can be added without having to tweak the `Rakefile`.
But any source adventure that imports external ALAN modules (`.i`) will have to do so using absolute paths, since Rake will use the same compiler options for each adventure, so there's no way to specify an `-include <path>` command line option for specific adventures.


# Credits

None of these demo adventures contains an explicit copyright and license notice, but they are known to be freeware and freely reusable, since this has been the commonly accepted practice within the ALAN community.
It's worth noting that, like ALAN itself, many of these assets pre-date the era of FOSS licenses, so their original code base might as well been published long before many of the present day open source licenses existed.

Since all these adventures were included in the ALAN source repository at some point in time, and some of them were (and still are) included in the ALAN distribution packages, and because I've taken them for either the [ALAN website] or one of the ALAN packages, I'm hereby assuming that they fall under the same [Artistic License 2.0] that governs the ALAN IF project.


## Advent

This the ALAN version of the classic _[Advent]_ game (aka _[Colossal Cave Adventure]_) by [Don Woods] and [William Crowther], the very first text adventure that sat the whole genre in motion.

Written by Göran Forslund for ALAN&nbsp;2, adapted to ALAN&nbsp;3 by [Thomas Nilefalk]; creation and release dates unknown.
The game was never completed, so there's no winning point.

Source file taken from the [ALAN SDK 3.0beta8] for Windows (command line).

For more info on the various implementations of _[Advent]_, and the different titles under which it circulated, see [Baf's Guide _Advent_ entry].


## Saviour

Authored by [Thomas Nilefalk] and Göran Forslund (_ThoNi&GorFo Adventure Factories_).

Source file taken from the [ALAN SDK 3.0beta6] for Windows (GUI).

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[ALAN website]: https://www.alanif.se/ "Visit the Alan website"
[ALAN SDK 3.0beta6]: https://www.alanif.se/download-v3/official-releases/development-kits/development-kits-3-0beta6 "ALAN SDK 3.0beta6 downloads page"
[ALAN SDK 3.0beta8]: https://www.alanif.se/download-v3/official-releases/development-kits/development-kits-3-0beta8 "ALAN SDK 3.0beta8 downloads page"

[Artistic License 2.0]: https://opensource.org/licenses/Artistic-2.0 "View full text of the Artistic License 2.0"

<!-- Advent -->

[Advent]: https://www.ifwiki.org/Adventure "IF Wiki » Advent"
[Baf's Guide _Advent_ entry]: https://web.archive.org/web/20121228171612/http://wurb.com/if/game/1 "Baf's Guide » Advent (Web Archive)"
[Colossal Cave Adventure]: https://en.wikipedia.org/wiki/Colossal_Cave_Adventure "Wikipedia » Colossal Cave Adventure"

<!-- project files & folders -->

[advent.alan]: ./advent.alan "View adventure source file"
[cloak.alan]: ./cloak.alan "View adventure source file"
[saviour.alan]: ./saviour.alan "View adventure source file"
[saviour.png]: ./saviour.png "View image file"

<!-- people -->

[Don Woods]: https://en.wikipedia.org/wiki/Don_Woods_(programmer) "Wikipedia » Don Woods"
[Roger Firth]: http://www.firthworks.com/roger/ "Visit Roger Firth's website"
[Thomas Nilefalk]: https://github.com/thoni56 "View Thomas Nilefalk's GitHub profile"
[William Crowther]: https://en.wikipedia.org/wiki/William_Crowther_(programmer) "Wikipedia » William Crowther"

<!-- EOF -->
