#!/bin/bash -eu
main()
{
	local templateDir=$(git config --get --path init.templatedir)

	if [ ! -d .git ]
	then
		echo "This script is supposed to be run at the root of a git repository" >&2
	fi
	rsync --archive --verbose --compress --cvs-exclude $templateDir/hooks/ .git/hooks --delete
	rsync --archive --verbose --compress --cvs-exclude --exclude="update.sh" --exclude="tests" $templateDir/ .git
}
main
