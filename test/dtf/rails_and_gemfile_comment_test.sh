: init
typeset test_dir="${TMPDIR:-/tmp}/fdkngfk"
export GEM_HOME="${test_dir}/fake_gem_home"
export PATH="${test_dir}/fake_gem_home/bin:$PATH"

mkdir -p "${GEM_HOME}"
printf "source :rubygems\n\ngem 'rails'\n" > "${test_dir}/Gemfile"

yes | rake build
yes | rake install        # match=/installed/
gem install bundler # status=0

: test
builtin cd "${test_dir}"
bundle install             # match=/Installing rails/
yes | NOEXEC=0 rails new app1
[[ -f app1/Gemfile ]]      # status=0
[[ -f app1/Gemfile.lock ]] # status=0

: cleanup
rm -rf "${test_dir}"
