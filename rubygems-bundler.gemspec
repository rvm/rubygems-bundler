Gem::Specification.new do |s|
  s.name = "rubygems-bundler"
  s.version = "0.1.4"
  s.date = "2011-06-08"
  s.summary = "Make rubygems generate bundler aware executable wrappers"
  s.email = "mpapis@gmail.com"
  s.homepage = "https://github.com/mpapis/rubygems-bundler"
  s.description = "Integrate Rubygems, Bundler and RVM"
  s.has_rdoc = false
  s.authors = ["Michal Papis"]
  s.files = [
              "lib/rubygems_bundler/regenerate_binstubs_command.rb",
              "lib/rubygems_bundler/rubygems_bundler_installer.rb",
              "lib/rubygems_bundler/fix_wrapper.rb",
              "lib/rubygems_plugin.rb",
              "README.md",
              "rubygems-bundler.gemspec",
              "LICENSE",
            ]
  s.post_install_message = <<-TEXT
========================================================================

Thanks for installing rubygems-bundler!

It is important you understand that this gem can make your gem 
executables load in versions specified in Gemfile!

To make all the executables bundler compatible run:

    gem regenerate_binstubs # only once

To always use bundler add the following line to ~/.rvmrc or ~/.bashrc

    export USE_BUNDLER=force

now relogin or call in every open shell:

    export USE_BUNDLER=force

For more information read:

    https://github.com/mpapis/rubygems-bundler

========================================================================
TEXT
end
