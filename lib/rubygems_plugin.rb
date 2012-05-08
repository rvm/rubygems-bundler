require 'rubygems/version'

# Set the custom_shebang if user did not set one
Gem.pre_install do |inst|
  Gem.configuration[:custom_shebang] ||= '$env ruby_noexec_wrapper'
  require 'rubygems-bundler/install_the_wrapper' or true
end

if Gem::Version.new(Gem::VERSION) < Gem::Version.new('1.8.25') then
  # Add custom_shebang support to rubygems
  require 'rubygems-bundler/rubygems_bundler_installer'
end

require 'rubygems-bundler/regenerate_binstubs_command'
