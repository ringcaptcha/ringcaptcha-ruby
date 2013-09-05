# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ring_captcha/version'

Gem::Specification.new do |spec|
  spec.name          = "ring_captcha"
  spec.version       = RingCaptcha::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["you@example.com"]
  spec.description   = %q{library to access to RingCaptcha API}
  spec.summary       = %q{nothing for now}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
