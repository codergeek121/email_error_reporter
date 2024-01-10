require_relative "lib/email_error_reporter/version"

Gem::Specification.new do |spec|
  spec.name        = "email_error_reporter"
  spec.version     = EmailErrorReporter::VERSION
  spec.authors     = ["Niklas Haeusele"]
  spec.email       = ["niklas.haeusele@hey.com"]
  spec.homepage    = "https://github.com/codergeek121/email_error_reporter"
  spec.summary     = "Report your Rails errors via email."
  spec.description = "Report your Rails errors via email."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.required_ruby_version = '>= 3.1.0'
  spec.add_dependency "rails", ">= 7.0.0"
end
