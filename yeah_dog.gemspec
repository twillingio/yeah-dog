# frozen_string_literal: true

require_relative 'lib/yeah_dog/version'

Gem::Specification.new do |spec|
  spec.name = 'yeah_dog'
  spec.version = YeahDog::VERSION
  spec.authors = ['Tyler Willingham']
  spec.email = ['171991+tylerwillingham@users.noreply.github.com']

  spec.summary = 'This is nice'
  spec.description = 'This is a small, bundled set of tools to make working with Datadog a breeze'
  spec.homepage = 'https://twilling.io'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/twillingio/yeah-dog'
  spec.metadata['changelog_uri'] = 'https://github.com/twillingio/yeah-dog/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 6.0.0'
  spec.add_dependency 'ddtrace', '~> 1.0'

  spec.add_development_dependency 'debug'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
end
