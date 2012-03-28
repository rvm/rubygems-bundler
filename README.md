# Noexec

Let's stop using bundle exec, kthx.

## Installation

    gem install noexec

Then, in your .profile (or somewhere you can set env variables)

    RUBYOPT="-r`noexec`"

And you're done!

## How does this work?

It adds a script to every execution of ruby via the RUBYOPT environment variable. Then, when you run ruby, it takes a look at your working directory, and every directory above it until it can find a `Gemfile`. If the executable you're running is present in your Gemfile, it switches to using that `Gemfile` instead (via `Bundle.setup`).

Thank you Carl!!!!