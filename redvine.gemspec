# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redvine/version'

Gem::Specification.new do |gem|
  gem.name          = "redvine"
  gem.version       = Redvine::VERSION
  gem.authors       = ["Jay Stakelon"]
  gem.email         = ["jay@stakelon.com"]
  gem.description   = %q{A client for the unofficial Vine API.}
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/stakes/redvine"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httparty'
  gem.add_dependency 'hashie'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'autotest-standalone'
end
