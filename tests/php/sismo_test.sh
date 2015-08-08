#!/bin/bash

testIsRunOnCommit()
{
	php()
	{
		echo "$1" "$2" "$3" "$4" > "${SHUNIT_TMPDIR}/phpWasRun"
	}
	export -f php
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > someFile
	git add someFile
	git commit --quiet --message "Let's commit some file"
	sleep 1
	assertTrue 'Sismo was not run at all' "[ -f ${SHUNIT_TMPDIR}/phpWasRun ]"
	assertEquals 'Sismo was not run properly' \
		"/some/path --quiet build some-slug" \
		"$(cat "${SHUNIT_TMPDIR}/phpWasRun")"
}

initRepo()
{
	cd "$testRepo"
	rm --recursive --force .git
	git init --quiet .
	git config hooks.enabled-plugins php/sismo
	git config hooks.php-sismo.path /some/path
	git config hooks.php-sismo.slug some-slug
}

oneTimeSetUp()
{
	outputDir="${SHUNIT_TMPDIR}/output"
	mkdir "${outputDir}"

	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents "$testRepo"
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
