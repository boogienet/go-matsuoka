# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gomatsuoka/version'

Gem::Specification.new do |spec|
  spec.name          = "go-matsuoka"
  spec.version       = GoMatsuoka::VERSION
  spec.authors       = ["Ritchie Macapinlac"]
  spec.email         = ["rsmacapinlac@boogienet.com"]
  spec.summary       = %q{go-matsuoka is a command-line resource manager}
  spec.description   = %q{go-matsuoka is a command-line resource manager. It runs inside an IRB.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "rb-readline"
  spec.add_dependency "ripl"
  spec.add_dependency "ripl-commands"
  spec.add_dependency "activerecord"
  spec.add_dependency "sqlite3"
  spec.add_dependency "business_time"
  spec.add_dependency "libxml-ruby"
end
