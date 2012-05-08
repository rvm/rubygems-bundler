# Changelog

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
