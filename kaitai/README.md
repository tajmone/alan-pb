# Kaitai Struct

[![Kaitai Struct Version][kaitai badge]][kaitai link]&nbsp;
[![License][license badge]][LICENSE]

My custom ALAN 3 storyfile definition for [Kaitai Struct].

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Folder Contents](#folder-contents)
- [What is Kaitai Struct?](#what-is-kaitai-struct)
- [The a3c Definition](#the-a3c-definition)
- [Project Status](#project-status)
- [Reference Links](#reference-links)

<!-- /MarkdownTOC -->

-----

# Folder Contents

- [`alan_a3c.ksy`][alan_a3c.ksy] — ALAN storyfile (`.a3c`) definition (YAML) for [Kaitai Struct].
- [`LICENSE`][LICENSE] — MIT License.

# What is Kaitai Struct?

> Kaitai Struct is a declarative language used to describe various binary data structures, laid out in files or in memory: i.e. binary file formats, network stream packet formats, etc.

Kaitai definitions are stored and distributed in YAML files with extension `.ksy`.
These definitions for any format can then be used in two ways:

1. Via the [Kaitai Struct Compiler]  (**KSC**) to generate the source code of a parser for the given format, targeting one of the supported programming languages — C++, C#, Go , Java, JavaScript, Lua, Nim , Perl, PHP, Python, Ruby, Rust, Swift, and others (the number is growing).
2. Via the [Kaitai Struct Visualizer]  (**KSV**), the [Kaitai Web IDE], or any hex-editor that supports Kaitai Struct definitions, to inspect files in the given format.

# The a3c Definition

As far as this project is concerned, I'm currently mainly focused on the visualization use, i.e. using my Kaitai definition of the `.a3c` file format to inspect compiled storyfiles and compare the data with the results I'm getting with my hand-coded parsers, to ensure the parsing code is working as expected.

I use [Hex Editor Neo] for inspecting and working with binary files, and since Hex Editor Neo v7 introduced support for Kaitai Struct definitions, I find it very handy to use this tool and the a3c Kaitai definition while coding my storyfile parser(s).

End users who don't own an [Hex Editor Neo] _Pro_ or _Ultimate_ license can use the [Kaitai Web IDE] or the free [Kaitai Struct Visualizer] to achieve the same goal.

It's also worth noting that this type of use doesn't require the a3c definition to be 100% complete, whereas to generate a full parser I would need to cover not only the entire storyfile structure definition, but also provide functions to validate the CRC, unpack packed text strings, etc. — all of which is currently beyond my goals.

Nevertheless, once the a3c definition is mature enough, I will definitely consider polishing it and completing it so that it might be used with the [Kaitai Struct Compiler] to generate storyfile parsers.
This would pave the path to the creation of ALAN interpreters for the browser, mobile phones, and other architectures currently unsupported by ARun.

# Project Status

Right now the a3c definition is nothing more than a placeholder (just validates the storyfile "magic" signature).

See also my other [Hex Editor Neo] structure definition in this repository:

- [`../heneo/`](../heneo/)

# Reference Links

- [kaitai.io] — Kaitai Struct website.
- [Kaitai Web IDE]
- [Format Gallery] — Kaitai Struct definitions website.
- [github.com/kaitai-io]\:
    + [kaitai_struct_compiler] — aka **KSC** (Java).
    + [kaitai_struct_visualizer] — aka **KSV** ([Ruby Gem][KSV Gem]).
    + [kaitai_struct_formats] — library of binary file formats, as found at the [Format Gallery].
    + [awesome-kaitai]

<!-- MarkdownTOC:excluded -->
## Kaitai Documentation

- [doc.kaitai.io] — Kaitai Documentation:
    + [Kaitai Struct User Guide]
        * [4. Kaitai Struct language]
        * [5. Streams and substreams]
        * [6. Expression language]
        * [7. Advanced techniques]
        * [8. Common pitfalls]
    + [KSY Style Guide]
    + [KSY syntax diagram]

<!-- MarkdownTOC:excluded -->
## Hex Editor Neo

- [Hex Editor Neo Documentation] » [Structure Viewer Overview] » [Support for Kaitai Struct]

Now **[Hex Editor Neo]** supports Kaitai Struct definitions — only available with **Professional** and **Ultimate** editions, not with **Free** or **Standard**.


> Starting from version 7.01, Structure Viewer supports special kind of definition files, called Kaitai Struct.
>
> Kaitai definition files may be added to the library as standard structure definition files. They are automatically parsed and any defined structures are added to the library. The user may then bind those structures as usual.
>
> The built-in Structure Editor provides full support for Kaitai files, including syntax coloring and validation.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[kaitai.io]: https://kaitai.io "Kaitai Struct website"
[Kaitai Struct]: https://kaitai.io "Kaitai Struct website"

[Kaitai Struct Compiler]: https://github.com/kaitai-io/kaitai_struct_compiler "Kaitai Struct Compiler (KSC) GitHub repository: Java"
[Kaitai Struct Visualizer]: https://github.com/kaitai-io/ "Kaitai Struct Visualizer (KSV) GitHub repository: Ruby"

[Format Gallery]: https://formats.kaitai.io "Explore the Kaitai Struct definitions gallery"
[Kaitai Web IDE]: https://ide.kaitai.io "Kaitai Web IDE"

<!-- Kaitai GitHub -->

[github.com/kaitai-io]: https://github.com/kaitai-io "Kaitai team profile at GitHub"
[awesome-kaitai]: https://github.com/kaitai-io/awesome-kaitai
[kaitai_struct_formats]: https://github.com/kaitai-io/kaitai_struct_formats "Kaitai Struct definitions library"
[kaitai_struct_compiler]: https://github.com/kaitai-io/kaitai_struct_compiler "Kaitai Struct Compiler (KSC) GitHub repository: Java"
[kaitai_struct_visualizer]: https://github.com/kaitai-io/ "Kaitai Struct Visualizer (KSV) GitHub repository: Ruby"
[KSV Gem]: https://rubygems.org/gems/kaitai-struct-visualizer "Kaitai Struct Visualizer (KSV) at RubyGems.org"

<!-- Kaitai Docs -->

[doc.kaitai.io]: https://doc.kaitai.io "Kaitai Struct Documentation"

[Adding support for new target language]: https://doc.kaitai.io/new_language.html
[KST: Kaitai Struct Tests]: https://doc.kaitai.io/kst.html
[Kaitai Stream API]: https://doc.kaitai.io/stream_api.html

[KSY Style Guide]: https://doc.kaitai.io/ksy_style_guide.html
[KSY syntax diagram]: https://doc.kaitai.io/ksy_diagram.html

<!-- Kaitai Struct User Guide -->

[Kaitai Struct User Guide]: https://doc.kaitai.io/user_guide.html

[4. Kaitai Struct language]: https://doc.kaitai.io/user_guide.html#_kaitai_struct_language
[5. Streams and substreams]: https://doc.kaitai.io/user_guide.html#stream
[6. Expression language]: https://doc.kaitai.io/user_guide.html#_expression_language
[7. Advanced techniques]: https://doc.kaitai.io/user_guide.html#_advanced_techniques
[8. Common pitfalls]: https://doc.kaitai.io/user_guide.html#_common_pitfalls

<!-- Hex Editor Neo -->

[Hex Editor Neo]: https://www.hhdsoftware.com/hex-editor "Hex Editor Neo product page"

[Hex Editor Neo Documentation]: https://hhdsoftwaredocs.online/hex "Hex Editor Neo Documentation"
[Structure Viewer Overview]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/overview.html "Hex Editor Neo Documentation » Definitive Guide » Structure Viewer Overview » Support for Kaitai Struct"
[Support for Kaitai Struct]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/kaitai.html "Hex Editor Neo Documentation » Definitive Guide » Structure Viewer Overview"

<!-- project files -->

[alan_a3c.ksy]: ./alan_a3c.ksy "View Kaitai Struct definition"
[LICENSE]: ./LICENSE "View MIT License"

<!-- badges -->

[kaitai badge]: https://img.shields.io/badge/Kaitai_Struct-0.9-yellow
[kaitai link]: https://kaitai.io "Kaitai Struct version (click to visit website)"
[license badge]: https://img.shields.io/badge/license-MIT-blue

<!-- EOF -->
