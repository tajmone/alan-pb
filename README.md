[![Travis CI Status][travis badge]][travis link]&nbsp;
[![Alan version][alan badge]][alan link]&nbsp;
[![Ruby version][ruby badge]][ruby link]&nbsp;
[![Project licenses][license badge]][license link]&nbsp;

# ARun Playground

My personal playground for experimenting with [ALAN IF] adventures storyfile format and game interpreters in various programming languages: [PureBASIC].

- https://github.com/tajmone/arun-playground

Repository created in January 2020 by [Tristano Ajmone].

> **NOTE** — The repository was initially named `alan-pb`, since its main focus was on the [PureBASIC] language; in 2022/08/31 it was renamed to `arun-playground` to include other languages too.

-----

**Table of Contents**


<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2" -->

- [Repository Map](#repository-map)
- [Building](#building)
- [Licenses and Credits](#licenses-and-credits)
- [Reference Links](#reference-links)
    - [Alan](#alan)
    - [PureBasic](#purebasic)

<!-- /MarkdownTOC -->

-----

# Repository Map

- [`/_assets/`][_assets/] — project assets:
    + [`/adoc/`][adoc/] — custom [Asciidoctor] extensions and assets.
    + [`/rake/`][rake/] — custom [Rake] helpers.
- [`/adventures/demos/`][demos/] — source adventures for testing.
- [`/arun-c/`][arun-c/] — ARun 3.0beta8 C sources.
- [`/docs/`][docs/] — HTML documentation:
    + [`ARun-Clockwork.html`][ClockBook html] ([Live HTML Preview][ClockBook live])
    + [`ARun-PureBasic.html`][PBBook html] ([Live HTML Preview][PBBook live])
- [`/docs-src/`][docs-src/] — AsciiDoc sources.
- [`/heneo/`][heneo/] — [Hex Editor Neo] assets.
- [`/kaitai/`][kaitai/] — [Kaitai Struct] assets.
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


# Licenses and Credits

This repository contains multiple projects and assets organized into subfolders, each governed by its own license as indicated in the README document of each folder; consult those README files for information about authors and licenses.

-------------------------------------------------------------------------------

# Reference Links

## Alan

- [www.AlanIF.se][Alan] — the Alan website.
- [Alan IF Google Group] — for community help, announcements and discussions.
- [Alan sources on GitHub][Alan GH] — source code repository on GitHub.
- [Alan IF Development team] — GitHub profile and public projects.
- [Alan Docs] — GitHub repository for Alan documentation:
    + _[The Alan Manual]_ — online Alpha-edition of the latest _ALAN Adventure Language Reference Manual_ .

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
[_ARun Clockwork_ book]: #book-license "Learn more about the book license"
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

[Asciidoctor]: https://github.com/asciidoctor/asciidoctor "Visit Asciidoctor Ruby) repository"
[Eclint]: https://www.npmjs.com/package/eclint "EClint page at NPM"
[EditorConfig]: https://editorconfig.org "Visit the EditorConfig project website"
[Hex Editor Neo]: https://www.hhdsoftware.com/hex-editor "Visit Hex Editor Neo product page"
[Kaitai Struct]: https://kaitai.io "Visit Kaitai Struct website"
[Rake]: https://ruby.github.io/rake/ "Visit Rake website"
[Sublime Text 4]: https://www.sublimetext.com "Visit Sublime Text website"
[Travis CI]: https://travis-ci.com/ "Visit Travis CI website"

<!-- project files & folders -->

[_assets/]: ./_assets/ "Navigate to assets folder"
[adoc/]: ./_assets/adoc/ "Navigate to Asciidoctor assets folder"
[rake/]: ./_assets/rake/ "Navigate to Rake assets folder"

[arun-c/]: ./arun-c/ "Navigate to ARun C sources folder"
[demos/]: ./adventures/demos/ "Navigate to demo adventures folder"
[docs-src/]: ./docs-src/ "Navigate to AsciiDoc sources folder"
[docs/]: ./docs/ "Navigate to HTML docs folder"

[heneo/]: ./heneo/ "Navigate to Hex Editor Neo assets folder"
[kaitai/]: ./kaitai/ "Navigate to Kaitai Struct assets folder"

[pb/]: ./pb/ "Navigate to PureBasic sources folder"
[a3c/]: ./pb/a3c/ "Navigate to '/pb/a3c/' folder"

[LICENSE PB]: ./pb/a3c/LICENSE "View MIT License"
[LICENSE HENEO]: ./heneo/LICENSE "View MIT License"
[COPYING]: ./arun-c/COPYING "Read the Artistic License 2.0"

[ClockBook html]: ./docs/ARun-Clockwork.html "ARun-Clockwork.html (local preview)"
[ClockBook live]: https://htmlpreview.github.io/?https://github.com/tajmone/arun-playground/blob/main/docs/ARun-Clockwork.html "ARun-Clockwork.html (Live HTML Preview)"

[PBBook html]: ./docs/ARun-PureBasic.html "ARun-PureBasic.html (local preview)"
[PBBook live]: https://htmlpreview.github.io/?https://github.com/tajmone/arun-playground/blob/main/docs/ARun-PureBasic.html "ARun-PureBasic.html (Live HTML Preview)"

<!-- badges -->

[travis badge]: https://img.shields.io/travis/com/tajmone/arun-playground/main?logo=travis "Travis CI: EditorConfig validation status"
[travis link]: https://app.travis-ci.com/github/tajmone/arun-playground
[alan badge]: https://img.shields.io/badge/ALAN-3.0beta8-yellow
[alan link]: https://www.alanif.se/download-alan-v3/development-kits/development-kits-3-0beta8 "Tested with Alan SDK 3.0beta8"
[ruby badge]: https://img.shields.io/badge/Ruby-3.1.2-yellow
[ruby link]: https://www.ruby-lang.org "Requires Ruby 3"
[license badge]: https://img.shields.io/badge/license-various-blue
[license link]: #licenses-and-credits "Learn more about the multiple licenses of this repository"

<!-- people and organizations -->

[Alan IF Development team]: https://github.com/alan-if "Visit the Alan Interactive Fiction Development team organization on GitHub"

[Anssi Räisänen]: https://github.com/AnssiR66 "View Anssi Räisänen's GitHub profile"
[Tristano Ajmone]: https://github.com/tajmone "View Tristano Ajmone's GitHub profile"
[Thomas Nilefalk]: https://github.com/thoni56 "View Thomas Nilefalk's GitHub profile"

<!-- EOF -->
