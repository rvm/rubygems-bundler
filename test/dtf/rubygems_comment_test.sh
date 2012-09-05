: init
sm gem install # match=/installed/

yes | gem install haml          # match=/1 gem installed/

head -n 1 $(which haml)   # match=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=0

gem list                     # match=/haml/
rubygems-bundler-uninstaller # match=/haml/

head -n 1 $(which haml)   # match!=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=1

gem uninstall -x haml     # match=/Successfully uninstalled/
