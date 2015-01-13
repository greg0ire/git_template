#!/bin/bash -eu
main()
{
	local templateDir=$(git config --get --path init.templatedir)

	if [ ! -d .git ]
	then
		echo "This script is supposed to be run at the root of a git repository" >&2
	fi
	rm -rf .git/tests .git/docs .git/mkdocs.yml .git/README.md .git/LICENSE .git/CONTRIBUTING.md .git/update.sh
}
main
