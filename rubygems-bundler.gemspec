#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubygems-bundler/version"

Gem::Specification.new do |s|
  s.name        = "rubygems-bundler"
  s.version     = RubygemsBundler::VERSION
  s.authors     = ["Josh Hull", "Michal Papis"]
  s.email       = ["joshbuddy@gmail.com", "mpapis@gmail.com"]
  s.homepage    = "http://mpapis.github.com/rubygems-bundler"
  s.summary     = %q{Stop using bundle exec}
  s.description = %q{Stop using bundle exec. Integrate Rubygems and Bundler. Make rubygems generate bundler aware executable wrappers.}

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = ["noexec"]
  s.extensions  = ["ext/wrapper_installer/extconf.rb"]

  # Do we have to depend on those two ? Can we have two simple tasks doing the same ?
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
end
