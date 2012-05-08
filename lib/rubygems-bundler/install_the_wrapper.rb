# Copy wrapper
require 'fileutils'
require 'rubygems'

bindir       = Gem.respond_to?(:bindir,true) ? Gem.send(:bindir) : File.join(Gem.dir, 'bin')

wrapper_name = 'ruby_noexec_wrapper'
wrapper      = Gem.find_files(   wrapper_name )
destination  = File.expand_path( wrapper_name, bindir )

unless wrapper.empty? || File.exist?(destination)
  FileUtils.mkdir_p(bindir, :verbose => true)
  FileUtils.cp(wrapper.first, destination) 
  File.chmod(0775, destination)
end
