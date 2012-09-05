: init
export BUNDLE_GEMFILE=${TMPDIR:-/tmp}/Gemfile
printf "source :rubygems\n\ngem 'haml'\n" > ${BUNDLE_GEMFILE}

yes | sm gem install # match=/installed/
gem install bundler # status=0

bundle install

head -n 1 $(which haml)   # match=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=0

gem list                     # match=/haml/
rubygems-bundler-uninstaller # match=/haml/

head -n 1 $(which haml)   # match!=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=1

gem uninstall -x haml     # match=/Successfully uninstalled/
rm -f ${BUNDLE_GEMFILE}
