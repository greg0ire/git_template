#!/bin/bash -eu
main()
{
	local gitDir
	gitDir=$(git rev-parse --git-common-dir)

	rm -rf "$gitDir/{tests,docs,mkdocs.yml,README.md,LICENSE,CONTRIBUTING.md,update.sh}"
}
main
