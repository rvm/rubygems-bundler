DEBUG = ENV.key?('NOEXEC_DEBUG')

begin
  require "rubygems"
  require "bundler"

  module Bundler
    class << self
      def reset!
        @load = nil
      end
    end
  end

  module Noexec
    CURRENT = Dir.pwd

    extend self

    def log(msg)
      puts msg if DEBUG
    end

    def candidate?(gemfile, bin)
      config_file = File.expand_path('../.noexec.yaml', gemfile)
      log "Considering #{config_file.inspect}"
      if File.exist?(config_file)
        log "Using config file at #{config_file}"
        config = YAML::load_file(config_file)
        raise "You cannot have both an include and exclude section in your #{config_file.inspect}" unless config['include'].nil? ^ config['exclude'].nil?
        if config['include'] && config['include'].include?(bin)
          log "Binary included by config"
          return true
        elsif config['exclude'] && config['exclude'].include?(bin)
          log "Binary excluded by config"
          return false
        end
        log "Config based matching didn't find it, resorting to Gemfile lookup"
      end
      ENV['BUNDLE_GEMFILE'] = gemfile
      Bundler.load.specs.each do |spec|
        next if spec.name == 'bundler'
        return true if %w(ruby irb).include?(bin) || spec.executables.include?(bin)
      end
      false
    ensure
      Bundler.reset!
      ENV['BUNDLE_GEMFILE'] = nil
    end

    def setup
      log "Noexec"
      return if %w(bundle rubygems-bundler-uninstaller).include?(File.basename($0))   
      return if ENV['BUNDLE_GEMFILE'] && ENV['BUNDLE_BIN_PATH'] && ENV['RUBYOPT']
      return if %w(0 skip).include?( ENV['NOEXEC'] )
      gemfile = ENV['BUNDLE_GEMFILE'] || File.join(CURRENT, "Gemfile")
      while true
        if File.exist?(gemfile)
          log "Examining #{gemfile}"
          if Noexec.candidate?(gemfile, File.basename($0))
            log "Using #{gemfile}"
            ENV['BUNDLE_GEMFILE'] = gemfile
            Bundler.setup
            return
          end
        end
        new_gemfile = File.expand_path("../../Gemfile", gemfile)
        break if new_gemfile == gemfile
        gemfile = new_gemfile
      end
      log "No valid Gemfile found, moving on"
    end
  end

  Noexec.setup
rescue LoadError
  warn "bundler not being used, unable to load" if DEBUG
end
