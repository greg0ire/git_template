# A set of useful git hooks

These hooks automate some tasks with the help of git.

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

## Configuration

Set the newly cloned repo as your git template directory. This will tell git to
populate new repositories created with either `git clone` or `git init` with
the content of this directory. By default, it uses `/usr/share/git-core/templates`.

    git config --global init.templatedir '~/.git_template'

## What's inside ?

For the moment, mostly hooks related to tools from the php ecosystem.

### Exuberant Ctags hook

Updates .git/tags file by scanning the project with the ctags command. It is
configured for a php project. To make vim look for this file in the `.git`
directory, you can install Tim Pope's [fugitive][4].

### Composer hook

This set of scripts monitor `composer.lock` changes and updates your vendor
dependencies when appropriate. It assumes Composer is [globally installed][1].

### Sismo hook

The post-commit hook makes [Sismo][2] run each time you commit. Make sure you
configure the environment variables in your hooksrc properly. It is a post-commit
hook because Sismo is a *local* Continuous Testing Server, which means you can
build before you push.

### Doctrine hook

This hooks runs the `doctrine:schema:validate` task of a Symfony project and
updates / migrates your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory.

### Junk checker hook

Checks for user defined phrases that you don't want to commit to your
repository, such as `var_dump()`, `console.log()` etc.

This can be overridden by doing a:

    git commit --no-verify

This hook is language-agnostic.

## Usage

Start by creating your hooksrc file:

    mv .git/hooks/hooksrc.sample .git/hooks/hookrc

Then edit it to add plugins you wish to activate. The sample file contains the
ctags and composer hooks by default.

## Contributing

Creating your php plugin is as easy as creating a php folder under `hooks/php`.
You can then create hooks in it. For the moment, only the following are supported
(because I'm lazy)

* post-commit
* post-checkout
* post-merge
* post-rewrite

If you need to add configuration variables in the hooksrc, you need to prefix
them with the path to your hook, which is obviously unique. This will avoid
variable names collisions.

## Source

Inspired by [Tim Pope][3]

[1]: https://github.com/composer/composer#global-installation-of-composer-manual
[2]: http://sismo.sensiolabs.org/ "A local Continuous Testing Server"
[3]: http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
[4]: https://github.com/tpope/vim-fugitive
