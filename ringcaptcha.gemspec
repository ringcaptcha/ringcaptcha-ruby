# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/ringcaptcha/version'

Gem::Specification.new do |spec|
  spec.name          = "ringcaptcha"
  spec.version       = RingCaptcha::VERSION
  spec.authors       = ["Martin Cocaro"]
  spec.email         = ["martin@ringcaptcha.com"]
  spec.description   = %q{library to access to RingCaptcha API}
  spec.summary       = %q{library to access to RingCaptcha API}
  spec.homepage      = "http://ringcaptcha.com"
  spec.license       = "MIT"

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
