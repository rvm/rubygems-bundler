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
wrapper=File.expand_path('../../../bin/bundler_wrapper',File.absolute_path(__FILE__))
destination=File.expand_path('bin/bundler_wrapper',Gem.dir)
FileUtils.cp(wrapper, destination, :verbose => true)
File.chmod(0755, destination)
