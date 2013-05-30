require "yaml"

module RubygemsBundler
end
RubygemsBundler::DEBUG = ENV.key?('NOEXEC_DEBUG')

if %w(bundle rubygems-bundler-uninstaller).include?(File.basename($0))
  puts "Noexec - skipped binary: #{File.basename($0)}" if RubygemsBundler::DEBUG

elsif ENV['NOEXEC_EXCLUDE'] && ENV['NOEXEC_EXCLUDE'].split(/ /).include?(File.basename($0))
  puts "Noexec - ENV skipped binary: #{File.basename($0)}" if RubygemsBundler::DEBUG

elsif ENV['BUNDLE_GEMFILE'] && ENV['BUNDLE_BIN_PATH'] && ENV['RUBYOPT']
  puts "Noexec - already in 'bundle exec'" if RubygemsBundler::DEBUG

elsif %w(0 skip).include?( ENV['NOEXEC'] ) || ENV.key?('NOEXEC_DISABLE')
  #TODO: deprecated in 1.1.0, to be removed in 1.2.0 -- 2012.09.05
  $stderr.puts "Warning, 'NOEXEC' environment variable is deprecated, switch to 'NOEXEC_DISABLE=1'." if ENV.key?('NOEXEC')
  puts "Noexec - disabled with environment variable" if RubygemsBundler::DEBUG

else
  begin
    puts "Noexec - starting check" if RubygemsBundler::DEBUG
    require "rubygems"
    require "bundler-unload"

    module Noexec
      RubygemsBundler::CURRENT = Dir.pwd

      extend self

      def log(msg)
        puts msg if RubygemsBundler::DEBUG
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
        Bundler.with_bundle do
          load.specs.each do |spec|
            next if spec.name == 'bundler'
            return true if %w(ruby irb).include?(bin) || spec.executables.include?(bin)
          end
        end
        false
      rescue Bundler::BundlerError, Bundler::GemfileError => e
        warn "Ignoring candidate #{gemfile}:\n#{e}" if RubygemsBundler::DEBUG
        false
      end

      def setup
        gemfile = ENV['BUNDLE_GEMFILE'] || File.join(RubygemsBundler::CURRENT, "Gemfile")
        while true
          if File.file?(gemfile)
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
    warn "bundler not being used, unable to load" if RubygemsBundler::DEBUG
  end
end
