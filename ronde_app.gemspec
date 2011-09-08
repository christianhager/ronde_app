# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ronde_app/version"

Gem::Specification.new do |s|
  s.name        = "ronde_app"
  s.version     = RondeApp::VERSION
  s.authors     = ["Chrisitan Hager"]
  s.email       = ["christian@hager.as"]
  s.homepage    = ""
  s.summary     = %q{Shared logic for apps}

  s.rubyforge_project = "ronde_app"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
