# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanber/rails/version'

Gem::Specification.new do |gem|
  gem.name          = "hanber-rails"
  gem.version       = Hanber::Rails::VERSION
  gem.authors       = ["logical42"]
  gem.email         = ["han@thirstlabs.com"]
  gem.description   = %q{ hacked version of ember-rails }
  gem.summary       = %q{ customized version of ember-rails for me, han }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "execjs", [">= 1.2"]
  gem.add_dependency "railties", [">= 3.1"]
  gem.add_dependency "active_model_serializers"
  gem.add_dependency "barber"

  gem.add_development_dependency "bundler", [">= 1.2.2"]
  gem.add_development_dependency "appraisal"
  gem.add_development_dependency "tzinfo"

end
