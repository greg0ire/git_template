#!/bin/bash
. .git/hooks/hook_switcher.sh

readonly PROGNAME=$(basename "$0")
readonly PROGDIR=$(readlink -m "$(dirname "$0")")

main() {
	local hookName
	if [ ! -d .git ]
	then
		echo "This script should be run from the root of a repository" >&2
		exit 1
	fi
	for directory in $(find "$PROGDIR/hooks" -type d | sort | \
	awk '$0 !~ last "/" {print last} {last=$0} END {print last}')
	do
		hookName=${directory#$PROGDIR/hooks/}
		echo "Configuring $hookName"
		switch_hook "$hookName"
		find "$directory" -name configure.sh -exec {} \;

	done
}

main
