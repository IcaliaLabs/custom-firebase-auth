require_relative "lib/icalialabs/firebase/version"

Gem::Specification.new do |spec|
  spec.name        = "icalialabs-firebase"
  spec.version     = Icalialabs::Firebase::VERSION
  spec.authors     = ["Jorge-Ortiz-Mata"]
  spec.email       = ["ortiz.mata.jorge@gmail.com"]
  spec.homepage    = "https://github.com/IcaliaLabs/custom-firebase-auth"
  spec.summary     = "Summary of Icalialabs::Firebase."
  spec.description = "Description of Icalialabs::Firebase."
    spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/IcaliaLabs/custom-firebase-auth"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/IcaliaLabs/custom-firebase-auth"
  spec.metadata["changelog_uri"] = "https://github.com/IcaliaLabs/custom-firebase-auth"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"

  spec.add_dependency "rubocop"
  spec.add_dependency "rspec"
  spec.add_dependency "rspec-rails"
end
