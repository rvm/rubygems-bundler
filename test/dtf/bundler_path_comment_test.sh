: init
export BUNDLE_GEMFILE=${TMPDIR:-/tmp}/Gemfile
export HAML_GIT_DIR=${TMPDIR:-/tmp}/haml
git clone https://github.com/haml/haml.git $HAML_GIT_DIR
printf "source :rubygems\n\ngem 'haml', :path => '${HAML_GIT_DIR}'\n" > ${BUNDLE_GEMFILE}

rake build
rake install # match=/installed/
gem install bundler # status=0

bundle install

head -n 1 $(which haml)   # match=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=0

bundle list                  # match=/haml/
rubygems-bundler-uninstaller # match=/haml/

head -n 1 $(which haml)   # match!=/env ruby_noexec_wrapper/
which ruby_noexec_wrapper # status=1

rm -rf ${BUNDLE_GEMFILE} ${HAML_GIT_DIR}
