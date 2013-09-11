#!/bin/bash -eu
readonly PROGDIR=$(readlink -m $(dirname $0))
main()
{
    # eval is needed to expand ~ to the home directory
    eval local templateDir=$(git config --get init.templatedir)
    if [ ! -d .git ]
    then
        echo "This script is supposed to be run at the root of a git repository" >&2
    fi
    rsync -avzC --exclude="update.sh" $PROGDIR/hooks/ .git/hooks --delete
    rsync -avzC --exclude="update.sh" $PROGDIR/ .git
}
main
