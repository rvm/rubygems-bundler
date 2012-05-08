require 'rubygems-bundler/wrapper'
require 'rubygems-bundler/regenerate_binstubs_command'

module RubygemsBundler
  def self.uninstall
    Gem.configuration[:custom_shebang] = '$env ruby'
    RegenerateBinstubsCommand.new.execute_no_wrapper
    Wrapper.uninstall
  end
end
