# ALAN PureBasic Docs Sources

AsciiDoc sources of the project documentation found in the [`/docs/`][docs/] folder:

- [`../docs/ARun-PureBasic.html`][ARunPB html] ([Live HTML Preview][ARunPB live])

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Custom Asciidoctor Macros](#custom-asciidoctor-macros)

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
    + [`arun-src-linker.rb`][arun rb]
    + [`arun-src-linker-info.html`][arun html] ([Live HTML Preview][arun live])

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

<!-- project files & folders -->

[ARunPB html]: ../docs/ARun-PureBasic.html "ARun-PureBasic.html (local preview)"
[ARunPB live]: https://htmlpreview.github.io/?https://github.com/tajmone/alan-pb/blob/main/docs/ARun-PureBasic.html "ARun-PureBasic.html (Live HTML Preview)"

[docs/]: ../docs/ "Navigate to HTML docs folder"

[adoc/]: ../_assets/adoc/ "Navigate to Asciidoctor assets folder"

[arun rb]: ../_assets/adoc/arun-src-linker.rb
[arun html]: ../_assets/adoc/arun-src-linker-info.html
[arun live]: https://htmlpreview.github.io/?https://github.com/tajmone/alan-pb/blob/main/_assets/adoc/arun-src-linker-info.html "Asciidoctor ARun extension (Live HTML Preview)"

<!-- EOF -->
