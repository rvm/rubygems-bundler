#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

Kernel.load File.expand_path("../lib/rubygems-bundler/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rubygems-bundler"
  s.version     = RubygemsBundler::VERSION
  s.authors     = ["Josh Hull", "Michal Papis"]
  s.email       = ["joshbuddy@gmail.com", "mpapis@gmail.com"]
  s.homepage    = "http://mpapis.github.com/rubygems-bundler"
  s.summary     = %q{Stop using bundle exec}
  s.description = %q{Stop using bundle exec. Integrate Rubygems and Bundler. Make rubygems generate bundler aware executable wrappers.}
  s.license     = 'Apache License, Version 2.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency "bundler-unload", ">=1.0.1"
  s.add_dependency "executable-hooks", ">=1.1.0"
  s.add_development_dependency "tf"
  #s.add_development_dependency "smf-gem"
end
