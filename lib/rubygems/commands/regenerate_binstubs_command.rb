require 'yaml'
require 'rubygems/installer'

class Gem::Commands::RegenerateBinstubsCommand < Gem::Command
  def initialize
    super 'regenerate_binstubs', 'Re run generation of executable wrappers for gems.'
  end

  def arguments # :nodoc:
    "STRING        start of gem name to regenerate binstubs"
  end

  def usage # :nodoc:
    "#{program_name} [STRING]"
  end

  def defaults_str # :nodoc:
    ""
  end

  def description # :nodoc:
    'Re run generation of executable wrappers for all gems. '+
    'Wrappers will be compatible with both rubygems and bundler. '+
    'The switcher is BUNDLE_GEMFILE environment variable, '+
    'when set it switches to bundler mode, when not set, '+
    'then the command will work as it was with pure rubygems.'
  end

  def execute
    name = get_one_optional_argument || ''
    specs = Gem.source_index.search Gem::Dependency.new /^#{name}/i, Gem::Requirement.default
    specs.each do |spec|
      unless spec.executables.empty?
        puts "#{spec.name} #{spec.version}"
        inst = Gem::Installer.new Dir[File.join(Gem.dir, 'cache', spec.file_name)].first, :wrappers => true, :force => true
        class << inst
          include Gem::BundlerInstaller
        end
        inst.bundler_generate_bin
      end
    end
  end
end