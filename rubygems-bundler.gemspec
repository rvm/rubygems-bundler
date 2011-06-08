Gem::Specification.new do |s|
  s.name = "rubygems-bundler"
  s.version = "0.1.3"
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
end
