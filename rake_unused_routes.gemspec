# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_unused_routes/version'

Gem::Specification.new do |spec|
  spec.name          = "rake_unused_routes"
  spec.version       = RakeUnusedRoutes::VERSION
  spec.authors       = ["Karl Baum"]
  spec.email         = ["karl.baum@gmail.com"]

  spec.summary       = %q{Helps find unused routes given a list of live controllers.}
  spec.description   = %q{Uses exports of live controllers to generate unused routes.  Uses the same formatting as newrelic controller exports. }
  spec.homepage      = "https://github.com/viewthespace/rake_unused_routes"
  spec.license       = "MIT"

  spec.rubyforge_project = 'rake_unused_routes'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_dependency 'rails', ['>= 3.0.0']
end
