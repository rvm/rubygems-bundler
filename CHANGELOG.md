# Changelog

## 1.4.2
date: 2013-10-28

 - reset BUNDLE_GEMFILE before finishing, fix #57

## 1.4.1
date: 2013-10-23

 - restore loading Bundler.setup for git gems to work, update mpapis/bundler-unload#3

## 1.4.0
date: 2013-10-20

 - skip unload! / load round trip when binary found in Gemfile, avoids mpapis/bundler-unload#3

## 1.3.4
date: 2013-10-04

 - move loading yaml when it is needed, fix #53

## 1.3.3
date: 2013-09-24

 - bump required versions of dependencies
 - improved logging in debug mode

## 1.3.2
date: 2013-09-22

 - fix detecting program name after fixing it, update mpapis/executable-hooks#5, update mpapis/bundler-unload#2

## 1.3.1
date: 2013-09-22

 - bump required versions of dependencies

## 1.3.0
date: 2013-09-21

 - Add license to gemspec, merge #51, fix #50
 - convert `noexec` to a class and move unscoped code to it
 - fail if the Gemfile version of gem can not be found, fix #37
 - extracted hooking into rubygems to executable-hooks gem, fix #44

## 1.2.2
date: 2013-07-10

 - remove references to rubygems_bundler_spec, update #49

## 1.2.1
date: 2013-07-05

 - improved checking if rubygems-bundler is loaded, fix #49

## 1.2.0
date: 2013-06-02

 - extracted bundler unloading to `bundler-unload` gem
 - fix saving / restoring gem specifications, update #41
 - add a global variable to ignore executables, fix #47
 - fix loading specs to restore in older rubygems, update #41
 - do not break on broken Gemfile, fix #41

## 1.1.0
date: 2012-09-05

 - move precheck to the beginning - fix `bundle _1.0.7_ ...`
 - fix #33, do not pollute global namespace
 - allow disabling with `NOEXEC_DISABLE=1` and deprecate `NOEXEC=0`

## 1.0.7
date: 2012-08-21

 - fix #27, fix #32, in case of bundler errors just ignore candidate gemfile

## 1.0.6
date: 2012-08-10

 -  fix #32, Gemfile should be a file

## 1.0.5
date: 2012-08-09

 -  fixing dependencies dtf -> tf

## 1.0.4
date: 2012-08-08

 -  fix #30, fix detecting old version in warning

## 1.0.3
date: 2012-06-20

 -  fix #28, check Bundler.settings only when `in_bundle?`

## 1.0.2
date: 2012-05-18

 - fix #24 disable loading plugin in case of disabled shared gems in bundler

## 1.0.1
date: 2012-05-17

 - fix #20, #22 improved detection of Bundler.setup
 - fix #19, #25 no more failing for git gems

## 1.0.0
date: 2012-05-09

 - removed the need to modify ~/.gemrc
 - change extensions code to an automatic installer
 - added uninstaller
 - removed old parts - there is only one way
 - fix bug with rubygems < 1.5

## 0.9.2
date: 2012-05-05

 - fix #16 fix --env-shebang

## 0.9.1
date: 2012-05-05

 - fix #15 respect --env-shebang
 - add latest rubygems changes

## 0.9.0
date: 2012-04-03

 - joining forces with noexec from
   [Joshua Hull - @joshbuddy](https://github.com/joshbuddy)

## 0.3.0
date: 2012-04-02

 - add support for [noexec gem](https://github.com/joshbuddy/noexec)
   from [Joshua Hull - @joshbuddy](https://github.com/joshbuddy)

## 0.2.8
date: 2011-12-27

 - fix #8 fixed bindir for systems with Gem.bindir outside of Gem.dir
 - merge #9 Prepend "ruby_" to wrapper filename

## 0.2.7
date: 2011-09-21

 - added uninstallation note
 - possibly fixed installation issue for older rubygems version (yaml related)

## 0.2.6
date: 2011-09-16

 - improved default blacklist handling
 - set $PROGRAM_NAME - update for thin
 - add group write permisions for binary

## 0.2.5
date: 2011-06-28

 - let `bundle*` commands handle bundler by itself
