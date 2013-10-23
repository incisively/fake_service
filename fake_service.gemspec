# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fake_service/version'

Gem::Specification.new do |spec|
  spec.name          = "fake_service"
  spec.version       = FakeService::VERSION
  spec.authors       = ["Anton Versal"]
  spec.email         = ["ant.ver@gmail.com"]
  spec.description   = %q{Fake service for reqres}
  spec.summary       = %q{Fake service for reqres}
  spec.homepage      = "https://github.com/antonversal/fake_service"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
end
