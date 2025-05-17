require_relative "lib/clickable_logger/version"

Gem::Specification.new do |spec|
  spec.name        = "clickable_logger"
  spec.version     = ClickableLogger::VERSION
  spec.authors     = ["Kasvit"]
  spec.email       = ["kasvit93@gmail.com"]
  spec.homepage    = "https://github.com/kasvit/clickable_logger"
  spec.summary     = "Clickable logger for Rails"
  spec.description = "Clickable logger for Rails logs in your editor"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kasvit/clickable_logger"
  spec.metadata["changelog_uri"]   = "https://github.com/kasvit/clickable_logger/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails"
  spec.add_development_dependency "debug"
end
