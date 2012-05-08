require 'rubygems/command_manager'
require 'rubygems/installer'
require 'rubygems/version'

class RegenerateBinstubsCommand < Gem::Command
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
    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('2.0.0') then
      # https://github.com/rubygems/rubygems/issues/326
      puts "try also: gem pristine --binstubs"
    end
    name = get_one_optional_argument || ''
    specs = installed_gems.select{|spec| spec.name =~ /^#{name}/i }
    specs.each do |spec|
      unless spec.executables.empty?
        org_gem_path = Gem.path.find{|path|
          File.exists? File.join path, 'gems', spec.full_name
        } || Gem.dir
        cache_gem = File.join(org_gem_path, 'cache', spec.file_name)
        if File.exist? cache_gem
          puts "#{spec.name} #{spec.version}"
          inst = Gem::Installer.new Dir[cache_gem].first, :wrappers => true, :force => true, :install_dir => org_gem_path
          RubyGemsBundlerInstaller.bundler_generate_bin(inst)
        else
          puts "##{spec.name} #{spec.version} not found in GEM_PATH"
        end
      end
    end
  end

  private
  def installed_gems
    if Gem::VERSION > '1.8' then
      Gem::Specification.to_a
    else
      Gem.source_index.map{|name,spec| spec}
    end
  end
end

Gem::CommandManager.instance.register_command :regenerate_binstubs
