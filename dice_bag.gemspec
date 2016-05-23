# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dice_bag/version'

Gem::Specification.new do |spec|
  spec.name          = "dice_bag"
  spec.version       = DiceBag::VERSION
  spec.authors       = ["Daniel Reedy"]
  spec.email         = ["danreedy@gmail.com"]
  spec.summary       = %q{Digital Dice Bag}
  spec.description   = %q{A CLI tool for generating random numbers for dice games.}
  spec.homepage      = "http://www.reedy.in"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "vcr", "~> 3.0.2"
  spec.add_development_dependency "webmock", "~> 2.0.3"
  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "activesupport", '~> 4.2.0'
  spec.add_dependency "to_words", '~> 1.1.0'
end
