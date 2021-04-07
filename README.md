# marble

**marble** is a Markdown formatter for Ruby. There are many gems which _consume_ Markdown but this gem allows you to _generate_ it.

This is useful if you need to interact with a service that expects correct Markdown, such as [Discord](https://github.com/shardlab/discordrb). The generated Markdown follows the [original spec](https://daringfireball.net/projects/markdown/syntax) with some common extensions (such as fenced code blocks and strikethrough).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marble_markdown'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install marble_markdown

## Usage

Upon importing the module

```ruby
require 'marble'
using Marble
```

formatting methods will be available in `Marble`. The most common operations are also added to `String` as extension methods, if you activate these with `using Marble`.

You can mix and match syntaxes:

```ruby
Marble.link('#RubyGems'.escape, 'https://rubygems.org/')
=> "[\\#RubyGems](https://rubygems.org/)"
```

And of course you can chain methods:

```ruby
'Marble!'.escape.bold.strikethrough.italic
=> "*~~**Marble\\!**~~*"
```

And use string interpolation to create more complex strings:

```ruby
"I am #{'bold'.bold} and I am #{'italic'.italic}!"
=> "I am **bold** and I am *italic*!"
```

All methods return strings.

---

### Marble

##### `Marble.escape(text)`
Return a string with all Markdown syntax escaped. Always use this for sanitising user input so that your own formatting is not broken.

"Markdown syntax" consists of:

```
["!", "#", "(", ")", "*", "[", "\\", "]", "_", "`", "|", "~"]
```

##### `Marble.bold(text)`
Create bolded Markdown text.

##### `Marble.code(text, language: nil)`
Create a code block. If `language` is not `nil`, the code block will be "fenced".

If you want a fenced code block with no syntax highlighting, set `language` to an empty string.

##### `Marble.italic(text)`
###### Aliases: `italics`
Create italicised Markdown text.

##### `Marble.strikethrough(text)`
###### Aliases: `strike`
Create struck-through Markdown text.

##### `Marble.quote(text)`
Create a block quote.

##### `Marble.link(text, url)`
Create a Markdown link.

##### `Marble.image(alt_text, url)`
Create a Markdown image.

##### `Marble.ordered_list(items, start: 1)`
###### Aliases: `ol`
Create an ordered list.

##### `Marble.unordered_list(items)`
###### Aliases: `ul`
Create an unordered list.

##### `Marble.horizontal_rule`
###### Aliases: `hr`
Create a horizontal rule.

##### `Marble.h1(title)`
##### `Marble.h2(title)`
##### `Marble.h3(title)`
##### `Marble.h4(title)`
##### `Marble.h5(title)`
##### `Marble.h6(title)`
Create headers of various levels.

---

### String

##### `String#escape`
This string with all Markdown syntax escaped.

##### `String#bold`
Embolden this string.

##### `String#code`
Display this string as code.

##### `String#italic`
###### Aliases: `italics`
Italicise this string.

##### `String#strikethrough`
###### Aliases: `strike`
Strike-out this string.

##### `String#link(url)`
Create a link using this string as the text.
