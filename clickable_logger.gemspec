# frozen_string_literal: true

require_relative "lib/clickable_logger/version"

Gem::Specification.new do |spec|
  spec.name = "clickable_logger"
  spec.version = ClickableLogger::VERSION
  spec.authors = ["Kasvit"]
  spec.email = ["kasvit93@gmail.com"]

  spec.summary = "A Rails gem that enhances logging by transforming file references into clickable links."
  spec.description = "ClickableLogger is a Rails gem that modifies log output to include clickable links for file references, enabling developers to quickly navigate to source files in their preferred editor. It's fully configurable and extensible, with support for custom matchers and easy integration."
  spec.homepage = "https://github.com/Kasvit/clickable_logger"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Kasvit/clickable_logger"
  spec.metadata["changelog_uri"] = "https://github.com/Kasvit/clickable_logger/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_development_dependency "capybara", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 5.0"
end
