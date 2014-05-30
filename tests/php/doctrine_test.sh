#!/bin/bash
testTriggeredOnValidateReturns2()
{
	console()
	{
		echo $1 > "${SHUNIT_TMPDIR}/consoleWasRun"
		return 2
	}
	read()
	{
		REPLY=y
	}
	export -f console
	export -f read
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > someFile
	git add someFile
	git commit --quiet --message "let's commit someFile" > /dev/null 2>&1
	assertEquals 'Update was not run' \
		"doctrine:schema:update" \
		"`cat ${SHUNIT_TMPDIR}/consoleWasRun`"

	mkdir --parents vendor/doctrine/migrations
	echo "b" > someFile
	git add someFile
	git commit --quiet --message "let's commit someFile" > /dev/null 2>&1
	assertEquals 'Migrate was not run' \
		"doctrine:migrations:migrate" \
		"`cat ${SHUNIT_TMPDIR}/consoleWasRun`"
}

testNoChangesWhenInvalidSchema()
{
	console()
	{
		echo $1 > "${SHUNIT_TMPDIR}/consoleWasRun"
		return 1
	}
	export -f console
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > someFile
	git add someFile
	git commit --quiet --message "let's commit someFile" > /dev/null 2>&1
	assertEquals 'Only validate was run' \
		"doctrine:schema:validate" \
		"`cat ${SHUNIT_TMPDIR}/consoleWasRun`"
}

initRepo()
{
	cd $testRepo
	rm --recursive --force .git
	git init --quiet .
	git config hooks.enabled-plugins php/doctrine
}

oneTimeSetUp()
{
	outputDir="${SHUNIT_TMPDIR}/output"
	mkdir "${outputDir}"
	stdoutF="${outputDir}/stdout"
	stderrF="${outputDir}/stderr"

	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents $testRepo
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. `which shunit2`
