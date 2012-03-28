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

    def candidate?(gemfile, bin)
      ENV['BUNDLE_GEMFILE'] = gemfile
      Bundler.load.specs.each do |spec|
        next if spec.name == 'bundler'
        return spec if %w(ruby irb).include?(bin) || spec.executables.include?(bin)
      end
      nil
    ensure
      Bundler.reset!
    end

    def setup
      puts "Noexec" if DEBUG
      return if File.basename($0) == 'bundle'
      return if ENV['BUNDLE_GEMFILE']
      gemfile = File.join(CURRENT, "Gemfile")
      while true
        if File.exist?(gemfile)
          puts "Examining #{gemfile}" if DEBUG
          if Noexec.candidate?(gemfile, File.basename($0))
            puts "Using #{gemfile}" if DEBUG
            ENV['BUNDLE_GEMFILE'] = gemfile
            Bundler.setup
            return
          end
        end
        new_gemfile = File.expand_path("../../Gemfile", gemfile)
        break if new_gemfile == gemfile
        gemfile = new_gemfile
      end
      puts "No valid Gemfile found, moving on" if DEBUG
    end
  end

  Noexec.setup
rescue LoadError
  warn "bundler not being used, unable to load" if DEBUG
end
