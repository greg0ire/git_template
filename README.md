# My personal set of git hooks

These hooks automate some tasks with the help of git

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

## Configuration

    git config --global init.templatedir '~/.git_template'

## What's inside ?

### Composer hook

This set of scripts monitor `composer.lock` changes and updates your vendor
dependencies when appropriate.

### Sismo hook

This hook makes [Sismo](http://sismo.sensiolabs.org/) run each time you commit.

### Doctrine hook

This hooks runs the `doctrine:schema:validate` task of a Symfony project and
updates / migrates your database depending on the presence of a
`doctrine-migrations` folder in your vendor directory.

## Usage

If you want to use a script, simply remove the .sample extension

## Source

Inspired by [Tim Pope](http://tbaggery.com/)
