# My personal set of git hooks

These hooks automate some tasks with the help of git.

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

## Configuration

Set the newly cloned repo as your git template directory. This will tell git to
populate new repositories created with either `git clone` or `git init` with
the content of this directory. By default, it uses `/usr/share/git-core/templates`.

    git config --global init.templatedir '~/.git_template'

## What's inside ?

For the moment, php hooks only.

### Exuberant Ctags hook

Updates .git/tags file by scanning the project with the ctags command.

### Composer hook

This set of scripts monitor `composer.lock` changes and updates your vendor
dependencies when appropriate.

### Sismo hook

The post-commit hook makes [Sismo](http://sismo.sensiolabs.org/) run each time you commit.
Make sure you configure the environment variables in your hooksrc properly.

### Doctrine hook

This hooks runs the `doctrine:schema:validate` task of a Symfony project and
updates / migrates your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory.

### Junk checker hook

Checks for user defined phrases that you don't want to commit to your
repository, such as `var_dump()`, `console.log()` etc.

This can be overridden by doing a:

    git commit --no-verify

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

## Source

Inspired by [Tim Pope](http://tbaggery.com/)
