# -*- encoding: utf-8 -*-
require File.expand_path('../lib/croudia/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['wktk']
  gem.email         = ['wktk30@gmail.com']
  gem.description   = 'Ruby wrapper for the Croudia API'
  gem.summary       = 'Croudia API'
  gem.homepage      = 'https://github.com/wktk/croudia-gem'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'croudia'
  gem.require_paths = ['lib']
  gem.version       = Croudia::VERSION

  gem.add_dependency 'faraday', '~> 0.8.7'
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_development_dependency 'rake', '~> 10.1.0'
  gem.add_development_dependency 'rdoc', '~> 4.0.1'
  gem.add_development_dependency 'rspec', '~> 2.14.0'
  gem.add_development_dependency 'webmock', '~> 1.13.0'
end
