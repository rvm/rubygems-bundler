require 'rubygems/version'
require 'rubygems-bundler/wrapper'

# Set the custom_shebang if user did not set one
Gem.pre_install do |inst|
  Gem.configuration[:custom_shebang] ||= '$env ruby_noexec_wrapper'
  RubygemsBundler::Wrapper.install
end

if Gem::Version.new(Gem::VERSION) < Gem::Version.new('2.0') then
  # Add custom_shebang support to rubygems
  require 'rubygems-bundler/rubygems_bundler_installer'
end

require 'rubygems-bundler/regenerate_binstubs_command'
Gem::CommandManager.instance.register_command :regenerate_binstubs
