# frozen_string_literal: true

require_relative "lib/corduroy/version"

Gem::Specification.new do |spec|
  spec.name = "corduroy"
  spec.version = Corduroy::VERSION
  spec.authors = ["Andrew Hautau"]
  spec.email = ["arhautau@gmail.com"]

  spec.summary = "A collection of data structure and algorithm implementations."
  spec.description = "A collection of data structure and algorithm implementations."
  spec.homepage = "https://github.com/CrossTheStreams/corduroy"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/CrossTheStreams/corduroy/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib test]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "sorbet-runtime", "~> 0.5"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
