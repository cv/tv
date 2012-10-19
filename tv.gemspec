# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tv/version'

Gem::Specification.new do |gem|
  gem.name          = "tv"
  gem.version       = TV::VERSION
  gem.authors       = ['Carlos Villela']
  gem.email         = ['cv@lixo.org']
  gem.description   = %q{Load and replay VCR cassettes with ease}
  gem.summary       = %q{TV helps you assert that any cassettes recorded with VCR are still valid, by replaying them against the real services and comparing the responses with what was previously recorded.}
  gem.homepage      = 'http://github.com/cv/tv'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec'
end
