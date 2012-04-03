require 'rubygems/command_manager'
require 'rubygems-bundler/rubygems_bundler_installer'
require 'rubygems-bundler/regenerate_binstubs_command'

if Gem::VERSION < '1.9' then
  require 'rubygems-bundler/fix_wrapper'
end

Gem::CommandManager.instance.register_command :regenerate_binstubs
