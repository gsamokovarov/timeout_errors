$LOAD_PATH << File.expand_path("../lib", __FILE__)

require "timeout_errors/version"

Gem::Specification.new do |spec|
  spec.name          = "timeout_errors"
  spec.version       = TimeoutErrors::VERSION
  spec.authors       = ["Genadi Samokovarov"]
  spec.email         = ["gsamokovarov@gmail.com"]
  spec.summary       = %q(Catch all of them Net::HTTP timeout errors)
  spec.homepage      = "https://github.com/gsamokovarov/timeout_errors"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
