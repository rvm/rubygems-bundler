# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "noexec/version"

Gem::Specification.new do |s|
  s.name        = "noexec"
  s.version     = Noexec::VERSION
  s.authors     = ["Josh Hull"]
  s.email       = ["joshbuddy@gmail.com"]
  s.homepage    = "https://github.com/joshbuddy/noexec"
  s.summary     = %q{Stop using bundle exec}
  s.description = %q{Stop using bundle exec.}

  s.rubyforge_project = "noexec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
