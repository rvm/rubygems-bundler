: init
export BUNDLE_GEMFILE=${TMPDIR:-/tmp}/rubygems-bunelr_bundler-test/Gemfile
mkdir -p ${BUNDLE_GEMFILE%/*} # status=0
printf "source 'https://rubygems.org'\n\ngem 'haml'\n" | tee ${BUNDLE_GEMFILE}

yes | sm gem install         # match=/installed/
gem regenerate_binstubs      # status=0
gem install bundler          # status=0

bundle install

: exclusion
head -n 1 "$(which haml)"     # match=/env ruby_executable_hooks/
NOEXEC_DEBUG=1 haml --version # match=/Using .*/rubygems-bunelr_bundler-test/Gemfile/; match!=/Binary excluded by config/
printf "exclude:\n - haml\n" > ${BUNDLE_GEMFILE%/*}/.noexec.yaml
NOEXEC_DEBUG=1 haml --version # match!=/Using .*/rubygems-bunelr_bundler-test/Gemfile/; match=/Binary excluded by config/

: generated/removed
head -n 1 "$(which haml)"    # match=/env ruby_executable_hooks/
which ruby_executable_hooks  # status=0

gem list                     # match=/haml/
executable-hooks-uninstaller # match=/haml/

head -n 1 $(which haml)      # match!=/env ruby_executable_hooks/
which ruby_executable_hooks  # status=1

gem uninstall -ax haml       # match=/Successfully uninstalled/
rm -rf ${BUNDLE_GEMFILE%/*}  # status=0
