# frozen_string_literal: true
#
# Copyright (C) 2021 biqqles.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'minitest/autorun'
require 'redcarpet'

require_relative '../lib/marble'

class MarbleTest < Minitest::Test
  def setup
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    @markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, strikethrough: true)
  end

  def test_escape
    example = '! # ( ) * [ \\ ] _ ` | ~'
    assert_equal '\\! \\# \\( \\) \\* \\[ \\\\ \\] \\_ \\` \\| \\~', example.escape

    more_sensible_example = 'Mary [*Had*](a) _Little_ Lamb'
    assert_equal "<p>Mary [*Had*](a) _Little_ Lamb</p>\n",
                 @markdown.render(Marble.escape(more_sensible_example))
  end

  def test_bold
    example = 'To go boldly'

    assert_equal "**#{example}**", example.bold
    assert_equal "<p><strong>#{example}</strong></p>\n", @markdown.render(example.bold)
  end

  def test_code
    example = 'puts "Hello world"'

    # test inline code
    assert_equal '`puts "Hello world"`',
                 example.code
    assert_equal @markdown.render(example.code),
                 "<p><code class=\"prettyprint\">puts &quot;Hello world&quot;</code></p>\n"

    # test block code
    block_code = Marble.code(example, language: 'ruby')

    assert_equal "```ruby\nputs \"Hello world\"\n```",
                 block_code


    assert_equal "<pre><code class=\"prettyprint lang-ruby\">puts &quot;Hello world&quot;\n</code></pre>\n",
                 @markdown.render(block_code)
  end

  def test_italic
    example = 'Emphasis'

    assert_equal "*#{example}*", example.italic
    assert_equal "<p><em>#{example}</em></p>\n", @markdown.render(example.italic)
  end

  def test_strikethrough
    example = 'Delete this nephew'

    assert_equal "~~#{example}~~", example.strikethrough
    assert_equal "<p><del>#{example}</del></p>\n", @markdown.render(example.strikethrough)
  end

  def test_quote
    example = 'Quotable'
    assert_equal "> #{example}", Marble.quote(example)
    assert_equal "<blockquote>\n<p>#{example}</p>\n</blockquote>\n", @markdown.render(Marble.quote(example))
  end

  def test_link
    example = 'This repository'
    example_url = 'https://github.com/biqqles/marble'

    assert_equal "[#{example}](#{example_url})", example.link(example_url)
    assert_equal "<p><a href=\"#{example_url}\">#{example}</a></p>\n", @markdown.render(example.link(example_url))
  end

  def test_image
    example = 'Alt text'
    example_url = 'https://www.ruby-lang.org/images/header-ruby-logo.png'

    assert_equal "![#{example}](#{example_url})",
                 Marble.image(example, example_url)

    assert_equal "<p><img src=\"#{example_url}\" alt=\"#{example}\"></p>\n",
                 @markdown.render(Marble.image(example, example_url))
  end

  def test_ordered_list
    example = %w[one two three four]

    assert_equal "1.   one\n2.   two\n3.   three\n4.   four\n",
                 Marble.ordered_list(example)

    assert_equal "<ol>\n<li>  one</li>\n<li>  two</li>\n<li>  three</li>\n<li>  four</li>\n</ol>\n",
                 @markdown.render(Marble.ordered_list(example))

    assert_equal "3.   one\n4.   two\n5.   three\n6.   four\n",
                 Marble.ordered_list(example, start: 3)
  end

  def test_unordered_list
    example = %w[one two three four]

    assert_equal "-   one\n-   two\n-   three\n-   four\n",
                 Marble.unordered_list(example)

    assert_equal "<ul>\n<li>  one</li>\n<li>  two</li>\n<li>  three</li>\n<li>  four</li>\n</ul>\n",
                 @markdown.render(Marble.unordered_list(example))
  end

  def test_horizontal_rule
    assert_equal '---', Marble.horizontal_rule
    assert_equal '---', Marble.hr
  end

  def test_headers
    example = 'Headers'

    assert_equal "# #{example}", Marble.h1(example)
    assert_equal "## #{example}", Marble.h2(example)
    assert_equal "### #{example}", Marble.h3(example)
    assert_equal "#### #{example}", Marble.h4(example)
    assert_equal "##### #{example}", Marble.h5(example)
    assert_equal "###### #{example}", Marble.h6(example)

    assert_equal "<h1>#{example}</h1>\n", @markdown.render(Marble.h1(example))
  end

  def test_readme
    assert_equal "[\\#RubyGems](https://rubygems.org/)",
                 Marble.link('#RubyGems'.escape, 'https://rubygems.org/')

    assert_equal "*~~**Marble\\!**~~*",
                 'Marble!'.escape.bold.strikethrough.italic

    assert_equal "I am **bold** and I am *italic*!",
                 "I am #{'bold'.bold} and I am #{'italic'.italic}!"
  end
end
