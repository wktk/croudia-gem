# -*- encoding: utf-8 -*-
require File.expand_path('../lib/croudia/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['wktk']
  gem.email         = ['wktk@wktk.in']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = 'https://github.com/wktk/croudia-gem'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'croudia'
  gem.require_paths = ['lib']
  gem.version       = Croudia::VERSION

  gem.add_dependency 'mechanize', '~> 2.5.1'
  gem.add_development_dependency 'rspec', '~> 2.10.1'
  gem.add_development_dependency 'webmock', '~> 1.8.7'
end
