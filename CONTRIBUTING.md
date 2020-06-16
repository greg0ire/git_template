# Contributing to git_template

## Running the test suite

First, you must make sure you're able to run the test suite.

Get this random [shunit2][1] fork in ~/src :

    git clone git@github.com:kward/shunit2.git

add the resulting directory to your `$PATH`, and run `tests/all.sh`.

## General contribution guidelines

Tabs are used for indention.

When using commands, prefer long options against short options. I invented the
following rule, please follow it:

> Short options are for the command line, long options are for scripts.

Also, try adding tests along with your contributions.

## Contributing a plugin

Creating your php plugin is as easy as creating a php folder under `hooks/php`.
You can then create hooks in it. For the moment, only the following are supported
(because I'm lazy)

* `post-commit`
* `post-checkout`
* `post-merge`
* `post-rewrite`
* `pre-push`
* `pre-commit`

If you need to add configuration variables git configuration, you should prefix
them with the path to your hook, which is obviously unique. This will avoid
collisions.

[1]: https://code.google.com/p/shunit2/
