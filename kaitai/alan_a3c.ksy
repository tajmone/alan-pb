# -------------------------------------------------------
# 'alan_a3c.ksy' | Alpha  2022/09/06 | by Tristano Ajmone
#                | Kaitai Struct 0.9 | ALAN 3.0beta8
# https://github.com/tajmone/arun-playground/kaitai/
# -------------------------------------------------------
meta:
  id: alan_a3c
  title: ALAN-IF v3 Storyfile
  file-extension: a3c
  license: MIT
  encoding: ASCII
  endian: be
doc: |
  ALAN-IF text adventure game.
  The '.a3c.' storyfile is a portable file format for text adventure
  games created with the ALAN-IF v3 authoring system.
  If a game contains multimedia resources, they will be stored seprately
  in a same-named file with the '.a3r' extension.
seq:
  - id: magic
    contents: ALAN
