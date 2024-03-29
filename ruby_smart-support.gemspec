# frozen_string_literal: true

require_relative 'lib/ruby_smart/support/version'

Gem::Specification.new do |spec|
  spec.name        = 'ruby_smart-support'
  spec.version     = RubySmart::Support.version
  spec.authors     = ['Tobias Gonsior']
  spec.email       = ['info@ruby-smart.org']
  spec.summary     = 'A toolkit of support libraries including GemInfo, ThreadInfo, Ruby core extensions & optionally activesupport extensions'
  spec.description = <<~DESC
    RubySmart::Support is a toolkit of support libraries for Ruby - major features includes GemInfo & ThreadInfo, as well core extensions for Ruby & activesupport (if installed).
  DESC

  spec.homepage              = 'https://github.com/ruby-smart/support'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/ruby-smart/support'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/ruby_smart-support'
  spec.metadata['changelog_uri']     = "#{spec.metadata["source_code_uri"]}/blob/main/docs/CHANGELOG.md"

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'activesupport', '>= 4.0'
  spec.add_development_dependency 'coveralls_reborn', '~> 0.25'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'yard-activesupport-concern', '~> 0.0.1'
  spec.add_development_dependency 'yard-relative_markdown_links', '>= 0.4'
end
