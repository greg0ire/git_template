# A set of useful git hooks

These hooks automate some tasks with the help of git.
For the moment, it is mostly hooks related to tools from the php ecosystem.

## Installation

    git clone git@github.com:greg0ire/git_template.git ~/.git_template

## Configuration

Set the newly cloned repo as your git template directory. This will tell git to
populate new repositories created with either `git clone` or `git init` with
the content of this directory. By default, it uses `/usr/share/git-core/templates`.

    git config --global init.templatedir '~/.git_template'

## Documentation

Read [the documentation][1] to learn more about git template.

## Updating

To get updates you need to update your template directory first :

```sh
# Go to your template directory (probably ~/.git_template)
cd $(git config --path --get init.templatedir)
git pull
```

Then, you can update any repository by running this in the working tree of your
repository :

```sh
$(git config --path --get init.templatedir)/update.sh
# If your template directory is ~/.git_template, this is equivalent to :
~/.git_template/update.sh
```

Make sure you have rsync installed.

## Setup on existing projects

You can also run the update script from a project created before your switch
to `git_template`, but be aware that any hook you created yourself will be deleted.

## Contributing

see [CONTRIBUTING.md][2]

## Credits

Inspired by [Tim Pope][3]

[1]: http://git-template.readthedocs.org
[2]: ./CONTRIBUTING.md
[3]: http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
