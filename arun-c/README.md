[![ARun version][arun badge]][arun link]&nbsp;
[![License][license badge]][COPYING]

# ARun C Sources

Unmodified Copy of the ARun C sources, for study and documentation purposes.

-----

**Table of Contents**

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="false" lowercase="only_ascii" uri_encoding="true" levels="1,2,3" -->

- [About](#about)
- [Changes](#changes)
- [License](#license)

<!-- /MarkdownTOC -->

-----

# About

This folder contains a copy of the ARun v3.0Beta8 C sources, as found in the `interpreter/` folder at the ALAN source repository with the [tag `v3.0Beta8` checkout][arun link].

I've opted for the sources of v3.0Beta8 since that's the latest Beta release available at the moment, but I'm not planning to updated the sources in the future, unless there are significant changes into ARun functionality.

The goal of including the ARun C sources in the repository is twofold:

1. As references for porting ARun to PureBasic.
2. For documentation purposes, allowing to include code snippets from the source files into the AsciiDoc source documents via `include::` directives.

# Changes

The source files underwent cosmetic changes (conversion of tabs indentation to spaces, removal of trailing spaces) to abide to the [EditorConfig] code styles conventions of this repository.

Since Asciidoctor allows [inclusion of code snippets via tagged regions], I'll be adding region-tags comments in the source files, as required.
Similarly, I shall include end of line comments with [callouts] markers, according to need.

None of the above changes affects the source code in any meaningful way, so the source files in this folder still qualify as being "Standard Version" (i.e. unmodified), as per the _Definitions_ section of the Artistic License 2.0:

> "Standard Version" refers to the Package if it has not been modified, or has been modified only in ways explicitly requested by the Copyright Holder.

They are "Standard Version" because their compilation would produce an identical ARun application as their upstream counterparts, but they are also "modified" to a certain extent, since the added region-tag or callouts comments are not present in the original.

Since the Artistic License 2.0 requires documenting any changes, I'm mentioning them even if they are merely cosmetic, just to be on the safe side of the license agreement:

> (4) You may Distribute your Modified Version as Source (either gratis or for a Distributor Fee, and with or without a Compiled form of the Modified Version) provided that you clearly document how it differs from the Standard Version, including, but not limited to, documenting any non-standard features,
executables, or modules, and provided that [...]

It's fairly clear from the above passage from the Artistic License that a "Modified" version implies changes to the actual code affecting the application's behaviour and its features.

# License

ALAN is &copy; Copyright of the original authors of [ALAN IF], and released under the [Artistic License 2.0].

The full text of the Artistic License 2.0 can be found in the following file inside this folder:

- [`COPYING`][COPYING]

Here's the summary declaration of intents by ALAN authors, as found in their added preamble to the license file:

> The Alan System is distributed under the Artistic License 2.0 for which the full text follows. The intent of this licensing is that the Copyright Holder retain some control over the development of the Alan System, while still keeping it available as open source and free software.
>
> In practical terms this means that the licensing is chosen so that it should be possible to
>
> - freely distribute games produced with the Alan system, including for profit
> - re-distribute compiled versions of the Alan system, including together with a game which is not open source or free, provided there is no charge for the
>   Alan system
> - redistribute compiled and/or source versions of the original Alan system (the Standard Version)
> - acquire the source code for the Standard Version
> - modify the source code for private use
> - re-distribute compiled and/or source of a Modified Version provided they are done so under a compatible license with appropriate attribution *and* that the modification is described and made available, preferably by returning it to
>   the Copyright Holder so that it can be merged into the Standard Version

If you're planning to reuse in any way they C sources found in this folder, then **_you must_** read the full text of the [`COPYING`][COPYING] license file, since the above preamble is not part of the legal text of the Artistic License 2.0.


<!-----------------------------------------------------------------------------
                               REFERENCE LINKS
------------------------------------------------------------------------------>

[Alan IF]: https://www.alanif.se/ "Visit the Alan website"
[ALAN source repository]: https://github.com/alan-if/alan "Visit ALAN source repository at GitHub"
[EditorConfig]: https://editorconfig.org "Visit EditorConfig website"
[Artistic License 2.0]:

<!-- Asciidoctor -->

[callouts]: https://docs.asciidoctor.org/asciidoc/latest/verbatim/callouts/
[inclusion of code snippets via tagged regions]: https://docs.asciidoctor.org/asciidoc/latest/directives/include-tagged-regions/ "AsciiDoc Language Documentation » Include Content by Tagged Regions"

<!-- badges -->

[arun badge]: https://img.shields.io/badge/ARun-3.0beta8-yellow
[arun link]: https://github.com/alan-if/alan/tree/v3.0beta8/interpreter "View ARun 3.0beta8 sources at upstream GitHub repository"
[license badge]: https://img.shields.io/badge/License-Artistic_License_2.0-blue

<!-- project files -->

[COPYING]: ./COPYING "Read the Artistic License 2.0"

<!-- EOF -->
