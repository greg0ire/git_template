# My personal set of git hooks

These hooks automate some tasks with the help of git.

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

## Configuration

    git config --global init.templatedir '~/.git_template'

## What's inside ?

For the moment, php hooks only.

### Exuberant Ctags hook

Updates .git/tags file by scanning the project with the ctags command.
Enabled by default.

### Composer hook

This set of scripts monitor `composer.lock` changes and updates your vendor
dependencies when appropriate. Enabled by default.

### Sismo hook

This hook makes [Sismo](http://sismo.sensiolabs.org/) run each time you commit.
Disabled by default, uncomment it in the post-commit hook.

### Doctrine hook

This hooks runs the `doctrine:schema:validate` task of a Symfony project and
updates / migrates your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory.
Disabled by default, uncomment it in all hooks.

## Usage

If your project is php project, then run

    ln -sv .git/php_hooks .git/hooks

## Source

Inspired by [Tim Pope](http://tbaggery.com/)
