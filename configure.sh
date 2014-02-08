#!/bin/bash
readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"

main() {
	if [ ! -d .git ]
	then
		echo "This script should be run from the root of a repository" >&2
		exit 1
	fi
	find $PROGDIR/hooks -name configure.sh -exec {} \;
}

main
