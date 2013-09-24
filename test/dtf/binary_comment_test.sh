: init
sm gem install   # match=/installed/
gem install rake # match=/1 gem installed/

: test binary
NOEXEC_DEBUG=1 rake --version
# match=/^Bin used: .*rake$/
# match=/^Bin calculated: rake$/
