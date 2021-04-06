# frozen_string_literal: true

require_relative 'lib/marble'

Gem::Specification.new do |spec|
  spec.name          = 'marble_markdown'
  spec.version       = Marble::VERSION
  spec.authors       = ['biqqles']
  spec.email         = ['biqqles@protonmail.com']

  spec.license       = 'MPL-2.0'
  spec.summary       = 'The Ruby Markdown formatter'
  spec.homepage      = 'https://github.com/biqqles/marble'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/releases"

  spec.files = ['lib/marble.rb']
  spec.require_paths = ['lib']
end
