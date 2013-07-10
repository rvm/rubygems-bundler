Gem.execute do |original_file|
  require 'rubygems'
  begin
    require 'rubygems-bundler/noexec'
  rescue LoadError
    warn "unable to load rubygems-bundler/noexec" if ENV.key?('NOEXEC_DEBUG')
  end
end
