# frozen_string_literal: true
#
# Copyright (C) 2021 biqqles.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# The Marble Markdown formatter.
module Marble
  VERSION = '0.1'

  # build a hash of characters that must be escaped and their escaped forms,
  # and a regex to detect the former.
  # not using Array#to_h to maintain compatibility below Ruby 2.6
  ESCAPED = %w{! # ( ) * [ \\ ] _ ` | ~}.map { |c| [c, "\\#{c}"] }.to_h
  TO_ESCAPE = Regexp.union(ESCAPED.keys)

  module_function

  # Return a string with all Markdown syntax escaped.
  # @param text [String]
  def escape(text)
    text.gsub(TO_ESCAPE, ESCAPED)
  end

  # Create bolded Markdown text.
  # @param text [String]
  # @return [String]
  def bold(text)
    "**#{text}**"
  end

  # Create a code block. If `language` is not `nil`, the code block will be "fenced".
  # If you want a fenced code block with no syntax highlighting, set `language` to an empty string.
  # @param text [String]
  # @param language [String, nil]
  def code(text, language: nil)
    if language.nil?
      "`#{text}`"
    else
      "```#{language}\n#{text}\n```"
    end
  end

  # Create italicised Markdown text.
  # @param text [String]
  # @return [String]
  def italic(text)
    "*#{text}*"
  end

  # Create struck-through Markdown text.
  # @param text [String]
  def strikethrough(text)
    "~~#{text}~~"
  end

  # Create a block quote.
  def quote(text)
    "> #{text}"
  end

  # Create a Markdown link.
  # @param text [String]
  # @param url [String]
  def link(text, url)
    "[#{text}](#{url})"
  end

  # Create a Markdown image.
  # @param alt_text [String]
  # @param url [String]
  def image(alt_text, url)
    "![#{alt_text}](#{url})"
  end

  # Create an ordered list.
  # @param items [Array<String>]
  # @param start [Integer]
  def ordered_list(items, start: 1)
    items.each.with_index(start).map { |item, n| "#{n}.   #{item}\n" }.join
  end

  # Create an unordered list.
  # @param items [Enumerable<String>]
  def unordered_list(items)
    items.map { |item| "-   #{item}\n" }.join
  end

  # Create a horizontal rule.
  def horizontal_rule
    '---'
  end

  # Create headers of various levels.
  def h1(title)
    "# #{title}"
  end

  def h2(title)
    "## #{title}"
  end

  def h3(title)
    "### #{title}"
  end

  def h4(title)
    "#### #{title}"
  end

  def h5(title)
    "##### #{title}"
  end

  def h6(title)
    "###### #{title}"
  end

  # define aliases
  class << self
    alias hr horizontal_rule
    alias ol ordered_list
    alias ul unordered_list
    alias italics italic
    alias strike strikethrough
  end
end

# The most common formatting operations are added to String as extension methods.
class String
  # This string with all Markdown syntax escaped.
  def escape
    Marble.escape self
  end

  # Embolden this string.
  def bold
    Marble.bold self
  end

  # Display this string as code.
  def code
    Marble.code self
  end

  # Italicise this string.
  def italic
    Marble.italic self
  end

  # Strike-out this string.
  def strikethrough
    Marble.strikethrough self
  end

  # Create a link using this string as the text.
  def link(url)
    Marble.link self, url
  end

  alias italics italic
  alias strike strikethrough
end
