#!/bin/bash
testRunsPhpCsFixerOnPhpFileChange()
{
	phpcsfixer()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/phpCsFixerWasRun"
	}
	export -f phpcsfixer
	export SHUNIT_TMPDIR
	initRepo
	mkdir --parents a/b
	echo "a" > a/b/c.php
	git add a/b/c.php
	git commit --quiet --message "first version of c.php"
	assertTrue 'PhpCsFixer was not run' "[ $(cat "${SHUNIT_TMPDIR}/phpCsFixerWasRun") == fix ]"
	rm "${SHUNIT_TMPDIR}/phpCsFixerWasRun"
}

testRunsPhpCsFixerOnNonPhpFileChange()
{
	phpcsfixer()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/phpCsFixerWasRun"
	}
	export -f phpcsfixer
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > file.js
	git add file.js
	git commit --quiet --message "first version of file.js"
	assertFalse 'PhpCsFixer was run' "[ -f "${SHUNIT_TMPDIR}/phpCsFixerWasRun" ]"
}

initRepo()
{
	cd "$testRepo"
	rm --recursive --force .git
	git init --quiet .
	git config hooks.enabled-plugins php/cs-fixer
	git config hooks.php-cs-fixer.executable phpcsfixer
}

oneTimeSetUp()
{
	outputDir="${SHUNIT_TMPDIR}/output"
	mkdir "${outputDir}"
	stderrF="${outputDir}/stderr"

	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents "$testRepo"
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
