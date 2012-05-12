rubygems_bundler_spec =
  if Gem::Specification.respond_to?(:find_by_name)
    Gem::Specification.find_by_name("rubygems-bundler")
  else
    Gem.source_index.find_name("rubygems-bundler").last
  end

called_version = __FILE__.sub(/^.*\/rubygems-bundler-([^\/]+)\/.*$/,'\1')

# continue only if loaded and called versions all the same
if rubygems_bundler_spec and rubygems_bundler_spec.version.to_s == called_version
  require 'rubygems/version'
  require 'rubygems-bundler/wrapper'

  # Set the custom_shebang if user did not set one
  Gem.pre_install do |inst|
    Gem.configuration[:custom_shebang] ||= '$env ruby_noexec_wrapper'
    RubygemsBundler::Wrapper.install
  end

  if Gem::Version.new(Gem::VERSION) < Gem::Version.new('2.0') then
    # Add custom_shebang support to rubygems
    require 'rubygems-bundler/rubygems_bundler_installer'
  end

  require 'rubygems-bundler/regenerate_binstubs_command'
  Gem::CommandManager.instance.register_command :regenerate_binstubs
elsif ENV.key?('NOEXEC_DEBUG')
  msg = "Older rubygems-bundler found, loaded: #{rubygems_bundler_spec.version}, called: #{called_version}, you can uninstall it with:\n\n    "

  error_source = __FILE__
  gem_source = File.expand_path("../../../..", error_source)
  gem_version = error_source.sub(/^.*\/rubygems-bundler-([^\/]+)\/.*$/,'\1')

  if ENV['GEM_HOME'] or ENV['GEM_PATH']
    msg << "GEM_HOME=\"#{gem_source}\" " unless ENV['GEM_HOME'] == gem_source
  end

  msg << "gem uninstall -ax rubygems-bundler -v #{gem_version}\n\n"

  puts msg
end
