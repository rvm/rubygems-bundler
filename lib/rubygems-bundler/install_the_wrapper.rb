# Copy wrapper
require 'fileutils'
require 'rubygems'

bindir       = Gem.respond_to?(:bindir,true) ? Gem.send(:bindir) : File.join(Gem.dir, 'bin')
wrapper_name = 'ruby_noexec_wrapper'
destination  = File.expand_path( wrapper_name, bindir )

rubygems_bundler_spec =
  if Gem::Specification.respond_to?(:find_by_name)
    Gem::Specification.find_by_name("rubygems-bundler")
  else
    Gem.source_index.find_name("rubygems-bundler").last
  end

if rubygems_bundler_spec
  wrapper_path = File.expand_path( "bin/#{wrapper_name}", rubygems_bundler_spec.full_gem_path )
end

if rubygems_bundler_spec && File.exist?(wrapper_path) && !File.exist?(destination)
  FileUtils.mkdir_p(bindir)
  FileUtils.cp(wrapper_path, destination)
  File.chmod(0775, destination)
end
