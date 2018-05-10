#!/bin/bash -eu
main()
{
	local templateDir=$(git config --get --path init.templatedir)
	local gitDir=$(git rev-parse --git-dir)

	rsync --archive --verbose --compress --cvs-exclude "$templateDir/hooks/" "$gitDir/hooks" --delete
	cp -f "$templateDir/configure.sh" "$gitDir"
}
main
