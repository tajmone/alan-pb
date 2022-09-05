# Hex Editor Neo

[![Hex Editor Neo Version][heneo badge]][Hex Editor Neo]&nbsp;
[![License][license badge]][LICENSE]

My custom ALAN 3 storyfile definition for [Hex Editor Neo]'s [Structure Viewer]  (requires Pro or Ultimate edition).

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [Folder Contents](#folder-contents)
- [About](#about)
- [Project Status](#project-status)
- [Reference Links](#reference-links)

<!-- /MarkdownTOC -->

-----

# Folder Contents

- [`alan.h`][alan.h] — main `a3c` definition.
- [`alan-types.h`][alan-types.h] — include file with ALAN types definitions.
- [`LICENSE`][LICENSE] — MIT License.

# About

[Hex Editor Neo] is a commercial hex editor which is also available in a [Free edition][Free Hex Editor Neo].

Since v6.01 [Hex Editor Neo] ships with a built-in [Structure Editor] that allows to create custom structure definitions (aka binary templates) for parsing new file types.
From the [Hex Editor Neo Features] page:

> #### Structure Viewer (binary templates)
>
> Hex Editor Neo provides an advanced data analysis and editing feature called Structure Viewer.
> This function allows you to bind binary templates to the data in such a way that each file or binary dump can be easily analyzed and edited using appropriate data format.
> For many known file types hex editor automatically loads built-in binary template from the library and parses the data according to the data format definition provided.
> Each field of structured data then could be edited.
> The product allows you to write your own format, add it to the library and then parse any custom data according to specified definition.
> You can exchange template files with your colleagues.

Custom structure definitions are only supported in the Professional and Ultimate editions.

# Project Status

The a3c custom definition is still incomplete and pretty much WIP.
I haven't been working on it since May 2019, using Hex Editor Neo 6.42.
In the meantime, [Hex Editor Neo] v7 was released, so my definitions might need to be updated to take advantage of new features.

> **NOTE** — I haven't yet had a chance to test if they still work with Hex Editor Neo 7.

# Reference Links

- [Free Hex Editor Neo] — Free edition website.
- [Hex Editor Neo] — product page for Standard, Professional and Ultimate editions.
    + [Editions Comparison] — features support for different editions.
- [Hex Editor Neo Documentation]
    + [Structure Viewer Overview]
        * [Structure Editor]
        * [Language Reference]

<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[Hex Editor Neo]: https://www.hhdsoftware.com/hex-editor "Visit Hex Editor Neo product page"
[Free Hex Editor Neo]: https://freehexeditorneo.com "Visit the website of Hex Editor Neo Free edition"
[Hex Editor Neo Features]: https://www.hhdsoftware.com/hex-editor#pr-features "View the full list of Hex Editor Neo features"
[Editions Comparison]: https://www.hhdsoftware.com/hex-editor#pr-editions "See which features are supported by the different Hex Editor Neo editions"

[Structure Viewer]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/overview.html "Learn more about Hex Editor Neo's Structure Viewer"

<!-- Hex Editor Neo Documentation -->

[Hex Editor Neo Documentation]: https://hhdsoftwaredocs.online/hex "Hex Editor Neo Documentation"

[Structure Viewer Overview]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/overview.html "Hex Editor Neo Documentation » Definitive Guide » Structure Viewer Overview"
[Structure Editor]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/structure-editor/overview.html "Hex Editor Neo Documentation » Definitive Guide » Structure Viewer Overview » Structure Editor"
[Language Reference]: https://hhdsoftwaredocs.online/hex/definitive-guide/structure-viewer/language-reference/overview.html "Hex Editor Neo Documentation » Definitive Guide » Structure Viewer Overview » Language Reference"

<!-- project files -->

[alan.h]: ./alan.h "View source file"
[alan-types.h]: ./alan-types.h "View source file"
[LICENSE]: ./LICENSE "View MIT License"

<!-- badges -->

[heneo badge]: https://img.shields.io/badge/Hex_Editor_Neo-6.42-yellow
[license badge]: https://img.shields.io/badge/license-MIT-blue

<!-- EOF -->
