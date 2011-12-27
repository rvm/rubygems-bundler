# Fake building extension
File.open('Makefile', 'w') { |f| f.write "all:\n\ninstall:\n\n" }
File.open('make', 'w') do |f|
  f.write '#!/bin/sh'
  f.chmod f.stat.mode | 0111
end
File.open('wrapper_installer.so', 'w') {}
File.open('wrapper_installer.dll', 'w') {}
File.open('nmake.bat', 'w') { |f| }

# Copy wrapper
require 'fileutils'
require 'rubygems'
bindir = Gem.respond_to?(:bindir,true) ? Gem.send(:bindir) : File.join(Gem.dir, 'bin')
wrapper=File.expand_path('../../bin/ruby_bundler_wrapper', Dir.getwd)
destination=File.expand_path('ruby_bundler_wrapper', bindir)
FileUtils.mkdir_p(bindir, :verbose => true)
FileUtils.cp(wrapper, destination, :verbose => true)
File.chmod(0775, destination)
