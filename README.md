# Noexec

Let's stop using bundle exec, kthx.

## Installation

    gem install noexec

Then, in your .profile (or somewhere you can set env variables)

    RUBYOPT="-r`noexec`"

And you're done!

## Configuration

Though you can let noexec do it's own thing and rely on looking up your binary via your Gemfile, you can also specify which binaries you want included or excluded. Create a .noexec.yaml file along side any Gemfiles you want to use. Then, to enable (or disable) the usage of your particular binary into your bundle, add an include or exclude section. For example:

### .noexec.yaml

    exclude: [rake]

Or, 

    include: [irb, ruby]

## Problems?

Things not going the way you'd like? Try your command again with NOEXEC_DEBUG=1 set and create a ticket. I'll fix it right away!

## How does this work?

It adds a script to every execution of ruby via the RUBYOPT environment variable. Then, when you run ruby, it takes a look at your working directory, and every directory above it until it can find a `Gemfile`. If the executable you're running is present in your Gemfile, it switches to using that `Gemfile` instead (via `Bundle.setup`).

Thank you Carl!!!!