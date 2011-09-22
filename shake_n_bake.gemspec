# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shake_n_bake/version"

Gem::Specification.new do |s|
  s.name        = "shake_n_bake"
  s.version     = ShakeNBake::VERSION
  s.authors     = ["Tom Wilson"]
  s.email       = ["tom@jackhq.com"]
  s.homepage    = ""
  s.summary     = %q{Shake and Bake is a simple dsl that allow you to check a system or service "Shake" then write or publish if there are results "bake"}
  s.description = %q{Shake and Bake is a simple dsl that allow you to check a system or service "Shake" then write or publish if there are results "bake"}

  s.rubyforge_project = "shake_n_bake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency('rspec')
end
