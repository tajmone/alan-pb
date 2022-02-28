=begin                    v1.0.0 | 2022/02/28 | by Tristano Ajmone | MIT License
================================================================================
An AsciiDoc extension providing an inline macro to easily generate links to ARun
sources at ALAN repository (checkout tag 'v3.0beta8'), specifically created for
the documentation of Alan Purebasic:

https://github.com/tajmone/alan-pb

It's designed to work with the HTML format only, results for other backends
were not tested nor taken care of.

Usage:
  arunsrc:<filename>[<optional attributes>]

were <filename> is a source file from the `interpreter/` folder of the ALAN
source repository, e.g.:

  arunsrc:memory.c[]

The allowed attributes are (in positional order and with their names):
  <line>  -> file line number
  <text>  -> show custom text instead of filename
  <plain> -> don't format text as inline code

Attributes can be passed by position or by name:

  arunsrc:main.c[394,load()]
  arunsrc:main.c[line=394,text=load()]

But unless you're omitting some initial attributes, you should simply pass them
by position.

If <line> is specified, the generated link will point to that line via #L<line>,
and after the filename it will print " (L.<line>)", unless custom text is
provided via <text>, in which case only the line-number anchor is added.

By default, <filename> and <text> are formatted as inline code, unless <plain>
is specified, e.g.

  arunsrc:Makefile[text="interpreter main Makefile",plain=true]

Substitutions and formatting in <text> won't work, it's treated as raw text.
================================================================================
=end

require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor


class ManInlineMacro < Extensions::InlineMacroProcessor
  use_dsl

  named :arunsrc
  name_positional_attributes ['line', 'text', 'plain']

  ARUN_BASE_URL = 'https://github.com/alan-if/alan/blob/v3.0beta8/interpreter/'

  def process parent, target, attrs
    filename = target
    linenum = attrs['line']
    if (text = attrs['text'])
        lineref = ''
    else
      text = %(#{filename})
      if linenum
        lineref = %( (L.#{linenum}))
      end
    end
    lineanchor = if linenum
      %(#L#{linenum})
    else
      nil
    end
    target_url = %(#{ARUN_BASE_URL}#{filename}#{lineanchor})
    if parent.document.basebackend? 'html'
      if !attrs['plain']
        textmono = "<code>#{text}</code>"
      else
        textmono = text
      end
      parent.document.register :links, target_url
      node = create_anchor parent, textmono, type: :link, target: target_url, attributes: {
        'title' => "View 'interpreter/#{filename}' source at ALAN repository",
        'window' => '_blank'
      }
    else # non-HTML formats are untested!
      node = create_inline parent, :quoted, filename
    end
    create_inline parent, :quoted, %(#{node.convert}#{lineref})
  end
end

# Register the extension:
Extensions.register :uri_schemes do
  inline_macro ManInlineMacro
end

=begin
================================================================================
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
================================================================================
=end
