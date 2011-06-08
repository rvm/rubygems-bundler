require 'rubygems/command_manager'
require 'rubygems_bundler/rubygems_bundler_installer'
require 'rubygems_bundler/fix_wrapper'
require 'rubygems_bundler/regenerate_binstubs_command'

Gem::CommandManager.instance.register_command :regenerate_binstubs