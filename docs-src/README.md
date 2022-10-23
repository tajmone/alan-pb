[![Alan version][alan badge]][alan link]&nbsp;
[![Asciidoctor version][adoc badge]][adoc link]&nbsp;
[![Ruby version][ruby badge]][ruby link]&nbsp;
[![License][license badge]][CC BY-NC-SA 4.0]

# ARun Playground Docs Sources

AsciiDoc sources of the project documentation found in the [`/docs/`][docs/] folder:


|        Source Folder        | Live HTML Preview  |                    Output Doc                   |
|-----------------------------|--------------------|-------------------------------------------------|
| [`/clockwork/`][clockwork/] | _[ARun Clockwork]_ | [`../docs/ARun-Clockwork.html`][Clockwork html] |

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Custom Asciidoctor Macros](#custom-asciidoctor-macros)
- [License](#license)

<!-- /MarkdownTOC -->

-----

# Custom Asciidoctor Macros

This documentation project uses a custom extension to add an _ad hoc_ inline macro to generate quick links to ARun C sources at the upstream ALAN repository:

    arunsrc:<filename>[<optional-attributes>]

Due to this custom extension, the document is only guaranteed to work well with the HTML5 backend (the macro output is untested for other formats),

E.g.

```asciidoc
See the arunsrc:memory.c[] source file.
```

For more info and usage instructions, see:

- [`../_assets/adoc/`][adoc/]:
    + [`arun-src-linker.rb`][linker rb]
    + [`arun-src-linker-info.html`][linker html] ([Live HTML Preview][linker live])

# License

The _[ARun Clockwork]_ book is Copyright &copy; 2022 [Tristano Ajmone], released under the terms of the [CC BY-NC-SA 4.0] license.

Unless otherwise specified, the same license terms apply to all other documents within this directory tree.

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[CC BY-NC-SA 4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/ "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International"

[Asciidoctor]: https://asciidoctor.org "Visit Asciidoctor website"

<!-- project files & folders -->

[Clockwork html]: ../docs/ARun-Clockwork.html "ARun-Clockwork.html (local preview)"
[ARun Clockwork]: https://htmlpreview.github.io/?https://github.com/tajmone/arun-playground/blob/main/docs/ARun-Clockwork.html "ARun-Clockwork.html (Live HTML Preview)"

[docs/]: ../docs/ "Navigate to HTML docs folder"
[adoc/]: ../_assets/adoc/ "Navigate to Asciidoctor assets folder"

[clockwork/]: ./clockwork/ 'Navigate to "ARun Clockwork" sources folder'

[linker rb]: ../_assets/adoc/arun-src-linker.rb
[linker html]: ../_assets/adoc/arun-src-linker-info.html
[linker live]: https://htmlpreview.github.io/?https://github.com/tajmone/arun-playground/blob/main/_assets/adoc/arun-src-linker-info.html "Asciidoctor ARun extension (Live HTML Preview)"

<!-- badges -->

[adoc badge]: https://img.shields.io/badge/Asciidoctor-2.0.17-yellow "Asciidoctor version employed"
[adoc link]: https://asciidoctor.org
[alan badge]: https://img.shields.io/badge/ALAN-3.0beta8-yellow
[alan link]: https://www.alanif.se/download-alan-v3/development-kits/development-kits-3-0beta8 "Tested with Alan SDK 3.0beta8"
[ruby badge]: https://img.shields.io/badge/Ruby-3.1.2-yellow
[ruby link]: https://www.ruby-lang.org "Requires Ruby 3"
[license badge]: https://img.shields.io/badge/license-CC_BY--NC--SA_4.0-blue

<!-- people and organizations -->

[Tristano Ajmone]: https://github.com/tajmone "View Tristano Ajmone's GitHub profile"

<!-- EOF -->
