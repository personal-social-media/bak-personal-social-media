# frozen_string_literal: true

require_relative "lib/personalsm/version"

Gem::Specification.new do |spec|
  spec.name          = "personalsm"
  spec.version       = Personalsm::VERSION
  spec.authors       = ["sebi"]
  spec.email         = ["gore.sebyx@yahoo.com"]

  spec.summary       = "Personal Social Media CLI"
  spec.description   = "Personal Social Media CLI to setup servers"
  spec.homepage      = "https://github.com/personal-social-media/personal-social-media"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/personal-social-media/personal-social-media"
  spec.metadata["changelog_uri"] = "https://github.com/personal-social-media/personal-social-media"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "net-ssh"
  spec.add_dependency "colorize"
  spec.add_dependency "net-sftp"
end
