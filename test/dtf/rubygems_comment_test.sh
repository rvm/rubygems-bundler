: init
sm gem install # match=/installed/

yes | gem install haml          # match=/1 gem installed/

head -n 1 $(which haml)   # match=/env ruby_executable_hooks/
which ruby_executable_hooks # status=0

gem list                     # match=/haml/
rubygems-bundler-uninstaller # match=/haml/

head -n 1 $(which haml)   # match!=/env ruby_executable_hooks/
which ruby_executable_hooks # status=1

gem uninstall -x haml     # match=/Successfully uninstalled/
