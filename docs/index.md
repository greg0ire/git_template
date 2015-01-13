# Git Template documentation

[Git Template][0] is a remplacement for the default directory that gets copied
each time you create or clone a git repository. It contains useful hooks along
with a configuration script that will let you to switch them on or off and
configure parameters when available, and an update script that will let you
update your copies.

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

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
$(git config --path --get init.templatedir)/update.sh
# If your template directory is ~/.git_template/template, this is equivalent to :
~/.git_template/template/update.sh
```

Make sure you have rsync installed.

## Setup on existing projects

You can also run the update script from a project created before your switch
to `git_template`, but be aware that any hook you created yourself will be deleted.

[0]: https://github.com/greg0ire/git_template
