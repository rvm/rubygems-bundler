require 'yaml'
require 'rubygems/installer'

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
    name = get_one_optional_argument || ''
    specs = installed_gems.select{|spec| spec.name =~ /^#{name}/i }
    specs.each do |spec|
      unless spec.executables.empty?
        cache_gem = File.join(Gem.dir, 'cache', spec.file_name)
        if File.exist? cache_gem
          puts "#{spec.name} #{spec.version}"
          inst = Gem::Installer.new Dir[cache_gem].first, :wrappers => true, :force => true
          RubyGemsBundlerInstaller.bundler_generate_bin(inst)
        else
          puts "##{spec.name} #{spec.version} not found in GEM_HOME"
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

    Gem::VERSION > '1.8' ? Gem::Specification._all : Gem.source_index.map{|name,spec| spec}

  end
end