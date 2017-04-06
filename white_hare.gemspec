# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'white_hare/version'

Gem::Specification.new do |spec|
  spec.name          = "white_hare"
  spec.version       = WhiteHare::VERSION
  spec.authors       = ["SAKAI, Kazuaki"]
  spec.email         = ["kaz.july.7@gmail.com"]

  spec.summary       = %q{A library for business date usages}
  spec.description   = %q{WhiteHare is a library for business date usage like the closing date.}
  spec.homepage      = "https://github.com/send/white_hare"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.12.0"
  spec.add_development_dependency "travis", "~> 1.8.2"
end
