[![Travis CI Status][travis badge]][travis link]&nbsp;
[![Alan version][alan badge]][alan link]&nbsp;
[![PureBasic Version][pb badge]][PureBasic]&nbsp;
[![Ruby version][ruby badge]][ruby link]&nbsp;
[![License][license badge]][LICENSE]

# ALAN PureBasic

My personal playground for experimenting with [ALAN IF] in [PureBASIC].

- https://github.com/tajmone/alan-pb

Repository created in January 2020 by [Tristano Ajmone].

-----

**Table of Contents**


<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3,4" -->

- [Repository Map](#repository-map)
- [Building](#building)
- [Code License](#code-license)
- [Book License](#book-license)
- [Third Party Assets](#third-party-assets)
    - [ARun Sources](#arun-sources)
- [Reference Links](#reference-links)

<!-- /MarkdownTOC -->

-----

# Repository Map

- [`/_assets/`][_assets/] — project assets:
    + [`/rake/`][rake/] — custom [Rake] helpers.
- [`/adventures/demos/`][demos/] — source adventures for testing.
- [`/arun-c/`][arun-c/] — ARun 3.0beta8 C sources.
- [`/docs/`][docs/] — HTML documentation:
    + [`ARun-PureBasic.html`][ARunPB html] ([Live HTML Preview][ARunPB live])
- [`/docs-src/`][docs-src/] — AsciiDoc sources.
- [`/pb/`][pb/] — PureBasic sources:
    + [`/a3c/`][a3c/] — Storyfiles parsing.

# Building

This repository uses [Rake] to manage the build toolchain.

To build the project for the first time, or update it when dependencies have changed, open the terminal (CMD, Bash, etc.) anywhere inside the repository and type:

    rake

To force rebuilding the whole project:

    rake -B

To delete all generated files and bring the repository to a pristine state:

    rake clobber

For more info on the available tasks:

    rake -T


# Code License

- [`LICENSE`][LICENSE]

All the PureBasic code in this repository (unless otherwise specified) is Copyright &copy; 2022 [Tristano Ajmone], released under the terms of the MIT License.

```
MIT License

Copyright (c) 2022 Tristano Ajmone <tajmone@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```

The above copyright and license notice does not apply to the [_ARun PureBasic_ book] found in this repository (also by Tristano Ajmone), nor to any [third party assets and sources].


# Book License

- [`/docs/`][docs/]
- [`/docs-src/`][docs-src/]

The [_ARun PureBasic_][ARunPB live] book is Copyright &copy; 2022 [Tristano Ajmone], released under the terms of the [CC BY-NC-SA 4.0] license.


# Third Party Assets

This repository also contains some demo adventures written by third parties.
For full credits and info on their authors, copyright and license, see the README file in their folder:

- [`/adventures/demos/`][demos/]

## ARun Sources

- [`/arun-c/`][arun-c/]

The original C sources of the ARun interpreter are &copy; Copyright of the original authors of [ALAN IF], and are released under the [Artistic License 2.0][COPYING].
More info is available in the README document inside the [`/arun-c/`][arun-c/] subfolder.

-------------------------------------------------------------------------------

# Reference Links

<!-- MarkdownTOC:excluded -->
## Alan

- [www.AlanIF.se][Alan] — the Alan website.
- [Alan IF Google Group] — for community help, announcements and discussions.
- [Alan sources on GitHub][Alan GH] — source code repository on GitHub.
- [Alan IF Development team] — GitHub profile and public projects.
- [Alan Docs] — GitHub repository for Alan documentation:
    + _[The Alan Manual]_ — online Alpha-edition of the latest _ALAN Adventure Language Reference Manual_ .

<!-- MarkdownTOC:excluded -->
## PureBasic

- [PureBasic website]
- [PureBasic Documentation]
- [PureBasic Forum English]
- [PureBasic Forum French]
- [PureBasic Forum German]
- [Fantaisie Software on GitHub]


<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[CC BY-NC-SA 4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International"
[_ARun PureBasic_ book]: #book-license "Learn more about the book license"
[third party assets and sources]: #third-party-assets "Learn more about third party assets and their licenses"

<!-- ALAN -->

[Alan]: https://www.alanif.se/ "Visit the Alan website"
[Alan IF]: https://www.alanif.se/ "Visit the Alan website"
[Alan IF Google Group]: https://groups.google.com/g/alan-if/ "Visit the Alan IF discussions group on Google Groups"
[Alan GH]: https://github.com/alan-if/alan/ "Visit the Alan source repository on GitHub"
[Alan SDK]: https://www.alanif.se/download-alan-v3/development-kits "Go to the Alan SDK section of the Alan website"

[Alan Docs]: https://github.com/alan-if/alan-docs "Visit the Alan Docs project on GitHub"
[The Alan Manual]: https://alan-if.github.io/alan-docs/manual-alpha/manual.html "'The Alan Manual' Alpha edition (online HTML)"

<!-- PureBasic -->

[PureBasic]: https://www.purebasic.com "Visit the PureBasic website"
[PureBasic website]: https://www.purebasic.com "Visit the PureBasic website"
[PureBasic Forum English]: https://www.purebasic.fr/english/ "Visit the PureBasic English Forum"
[PureBasic Forum French]: https://www.purebasic.fr/french/ "Visit the PureBasic French Forum"
[PureBasic Forum German]: https://www.purebasic.fr/german/ "Visit the PureBasic German Forum"
[PureBasic Documentation]: https://www.purebasic.com/documentation/index.html "Go to the online PureBasic Documentation"
[Fantaisie Software on GitHub]: https://github.com/fantaisie-software "Fantaisie Software GitHub profile"

<!-- 3rd party tools & services -->

[Eclint]: https://www.npmjs.com/package/eclint "EClint page at NPM"
[EditorConfig]: https://editorconfig.org "Visit the EditorConfig project website"
[Sublime Text 4]: https://www.sublimetext.com "Visit Sublime Text website"
[Travis CI]: https://travis-ci.com/ "Visit Travis CI website"
[Rake]: https://ruby.github.io/rake/ "Visit Rake website"

<!-- project files & folders -->

[_assets/]: ./_assets/ "Navigate to assets folder"
[arun-c/]: ./arun-c/ "Navigate to ARun C sources folder"
[demos/]: ./adventures/demos/ "Navigate to demo adventures folder"
[docs-src/]: ./docs-src/ "Navigate to AsciiDoc sources folder"
[docs/]: ./docs/ "Navigate to HTML docs folder"
[rake/]: ./_assets/rake/ "Navigate to assets folder"
[rake/]: ./_assets/rake/ "Navigate to assets folder"

[pb/]: ./pb/ "Navigate to PureBasic sources folder"
[a3c/]: ./pb/a3c/ "Navigate to '/pb/a3c/' folder"

[LICENSE]: ./LICENSE "View MIT License"
[COPYING]: ./arun-c/COPYING "Read the Artistic License 2.0"

[ARunPB html]: ./docs/ARun-PureBasic.html "ARun-PureBasic.html (local preview)"
[ARunPB live]: https://htmlpreview.github.io/?https://github.com/tajmone/alan-pb/blob/main/docs/ARun-PureBasic.html "ARun-PureBasic.html (Live HTML Preview)"

<!-- badges -->

[travis badge]: https://img.shields.io/travis/com/tajmone/alan-pb/main?logo=travis "Travis CI: EditorConfig validation status"
[travis link]: https://app.travis-ci.com/github/tajmone/alan-pb
[alan badge]: https://img.shields.io/badge/ALAN-3.0beta8-yellow
[alan link]: https://www.alanif.se/download-alan-v3/development-kits/development-kits-3-0beta8 "Tested with Alan SDK 3.0beta8"
[pb badge]: https://img.shields.io/badge/PureBasic-5.73-yellow
[ruby badge]: https://img.shields.io/badge/Ruby-3.0.3-yellow
[ruby link]: https://www.ruby-lang.org "Requires Ruby 3"
[license badge]: https://img.shields.io/badge/license-MIT-blue

<!-- people and organizations -->

[Alan IF Development team]: https://github.com/alan-if "Visit the Alan Interactive Fiction Development team organization on GitHub"

[Anssi Räisänen]: https://github.com/AnssiR66 "View Anssi Räisänen's GitHub profile"
[Tristano Ajmone]: https://github.com/tajmone "View Tristano Ajmone's GitHub profile"
[Thomas Nilefalk]: https://github.com/thoni56 "View Thomas Nilefalk's GitHub profile"

<!-- EOF -->
