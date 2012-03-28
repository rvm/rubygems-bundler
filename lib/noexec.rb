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
        return spec if spec.executables.include?(bin)
      end
      nil
    ensure
      Bundler.reset!
    end

    def setup
      puts "Noexec" if DEBUG
      catch(:done) do
        throw :done, false if File.basename($0) == 'bundle'
        gemfile = File.join(CURRENT, "Gemfile")
        while true
          if File.exist?(gemfile)
            puts "Examining #{gemfile}" if DEBUG
            if Noexec.candidate?(gemfile, File.basename($0))
              puts "Using #{gemfile}" if DEBUG
              Bundler.setup
              throw :done, true
            end
          end
          new_gemfile = File.expand_path("../../Gemfile", gemfile)
          throw :done, false if new_gemfile == gemfile
          gemfile = new_gemfile
        end
        puts "No valid Gemfile found, moving on" if DEBUG
        false
      end
    end
  end
rescue LoadError
  warn "bundler not being used, unable to load" if DEBUG
end
