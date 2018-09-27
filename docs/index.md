# Git Template documentation

Have you ever  commited an invalid `composer.json` ? a parse error ? changes that
 made the test suite go red ? or maybe debugging statements like
`var_dump`, `console.log`, `die` and so on ?
Have you ever accused your colleagues of breaking things when you really should
have run `composer install` or updated your database schema ?
Have you ever pushed a work in progress commit that you really meant to complete
a bit later ?

If this feels familiar, Git Template has your back, give it a try!

[Git Template][0] is a replacement for the default directory that gets copied
each time you create or clone a git repository. That's right, every time you
create or clone a git repository, some files get copied in your `.git` directory.
These files mostly consist of example hooks you may change and adapt to meet your
needs.
Git Template contains useful (mostly php-related) hooks along with a configuration
script that will let you to switch them on or off and configure parameters when
available, and an update script that will let you update your copies.

## Installation

    git clone https://github.com/greg0ire/git_template ~/.git_template

## Configuration

Set the newly cloned repo as your git template directory. This will tell git to
populate new repositories created with either `git clone` or `git init` with
the content of this directory. By default, it uses `/usr/share/git-core/templates`.

    git config --global init.templatedir '~/.git_template/template'

## Updating

To get updates you need to update your template directory first :

```sh
# Go to your template directory (probably ~/.git_template/template)
cd $(git config --path --get init.templatedir)
git pull
```

Then, you can update any repository by running this in the working tree of your
repository :

```sh
$(git config --path --get init.templatedir)/../update.sh
# If your template directory is ~/.git_template/template, this is equivalent to :
~/.git_template/update.sh
```

Make sure you have rsync installed.

## Setup on existing projects

You can also run the update script from a project created before your switch
to `git_template`, but be aware that any hook you created yourself will be deleted.

[0]: https://github.com/greg0ire/git_template
