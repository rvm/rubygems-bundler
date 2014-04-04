require "rubygems"

class Noexec
  DEBUG   = ENV['NOEXEC_DEBUG']
  CURRENT = Dir.pwd

  attr_reader :bin, :gemfile, :rubygems_specs

  def initialize(bin)
    log "Bin used: #{bin}"
    bin = bin.split(/ /)
    @bin = File.basename(bin[1]||bin[0])
    log "Bin calculated: #{@bin}"
  end

  def log(msg)
    puts msg if Noexec::DEBUG
  end

  def log2(msg=nil)
    if Noexec::DEBUG == "2"
      msg=yield if msg.nil? && block_given?
      puts msg
    end
  end

  def candidate?
    log "Examining #{gemfile}"
    config_file = File.expand_path('../.noexec.yaml', gemfile)
    if File.exist?(config_file)
      log "Using config file at #{config_file}"
      require "yaml"
      config = YAML::load_file(config_file)
      unless config['include'].nil? ^ config['exclude'].nil?
        raise "You cannot have both an include and exclude section in your #{config_file.inspect}"
      end
      if config['include'] && config['include'].include?(bin)
        log "Binary included by config"
        return true
      elsif config['exclude'] && config['exclude'].include?(bin)
        log "Binary excluded by config"
        return false
      end
      log "Config based matching didn't find it, resorting to Gemfile lookup"
    end
    runtime = Bundler.load
    log2(){ "runtime specs: #{runtime.specs.map{|g| "#{g.name}-#{g.version}"}*" "}" }
    if rubygems_spec # that single gem
      missing_spec = runtime.
        instance_variable_get(:@definition).
        missing_specs.
        detect{|spec| spec.name == rubygems_spec.name}
      if missing_spec
        puts "\e[31mCould not find proper version of #{missing_spec.to_s} in any of the sources\e[0m"
        puts "\e[33mRun `bundle install` to install missing gems.\e[0m"
        exit Bundler::GemNotFound.new.status_code
      end
    end
    if runtime.specs.detect{ |spec| spec.executables.include?(bin) }
      return true
    end
    Bundler.unload!(rubygems_specs)
    false
  rescue Bundler::BundlerError, Bundler::GemfileError => e
    warn "Ignoring candidate #{gemfile}:\n#{e}" if Noexec::DEBUG
    false
  end

  def old_specs
    if Hash === rubygems_specs
    then @rubygems_specs.values
    else @rubygems_specs
    end
  end

  def rubygems_spec
    @rubygems_spec ||= old_specs.detect{|spec| spec.executables.include?(bin) }
  end

  def setup
    puts "Noexec - starting check" if Noexec::DEBUG
    require "bundler-unload"

    @rubygems_specs = Bundler.rubygems.plain_specs # save it for unloading and checking binary
    log2(){ "rubygems_specs: #{rubygems_specs.map{|g| "#{g.name}-#{g.version}"}*" "}" }

    @gemfile = ENV['BUNDLE_GEMFILE'] || File.join(Noexec::CURRENT, "Gemfile")
    initial_env_gemfile = ENV['BUNDLE_GEMFILE']

    while true
      ENV['BUNDLE_GEMFILE'] = gemfile
      if File.file?(gemfile) && candidate?
        log "Keeping #{gemfile} loaded"
        Bundler.setup
        return
      end
      new_gemfile = File.expand_path("../../Gemfile", gemfile)
      break if new_gemfile == gemfile
      @gemfile = new_gemfile
    end
    log "No valid Gemfile found, moving on"
    ENV['BUNDLE_GEMFILE'] = initial_env_gemfile
  rescue LoadError
    warn "bundler not being used, unable to load" if Noexec::DEBUG
    ENV['BUNDLE_GEMFILE'] = initial_env_gemfile
  end

  def check
    if %w(bundle rubygems-bundler-uninstaller).include?(bin)
      log "Noexec - skipped binary: #{bin}"

    elsif ENV['NOEXEC_EXCLUDE'] && ENV['NOEXEC_EXCLUDE'].split(/ /).include?(bin)
      log "Noexec - ENV skipped binary: #{bin}"

    elsif ENV['BUNDLE_GEMFILE'] && ENV['BUNDLE_BIN_PATH'] && ENV['RUBYOPT']
      log "Noexec - already in 'bundle exec'"

    elsif %w(0 skip).include?( ENV['NOEXEC'] ) || ENV.key?('NOEXEC_DISABLE')
      #TODO: deprecated in 1.1.0, to be removed later -- 2012.09.05
      $stderr.puts "Warning, 'NOEXEC' environment variable is deprecated, switch to 'NOEXEC_DISABLE=1'." if ENV.key?('NOEXEC')
      log "Noexec - disabled with environment variable"

    else
      setup

    end
  end

end

Noexec.new($0).check
