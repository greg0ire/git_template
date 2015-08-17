#!/bin/bash
testTriggeredOnValidateReturns2()
{
	console()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/consoleArgs"
		return 2
	}
	read()
	{
		REPLY=y
	}
	touch "${SHUNIT_TMPDIR}/consoleArgs"
	export -f console
	export -f read
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > composer.lock
	git add composer.lock
	git commit --quiet --message "let's commit composer.lock" > /dev/null 2>&1
	assertEquals 'Update was not run' \
		"doctrine:schema:update" \
		"$(cat "${SHUNIT_TMPDIR}/consoleArgs")"

	mkdir --parents vendor/doctrine/migrations
	echo "b" > composer.lock
	git add composer.lock
	git commit --quiet --message "let's commit composer.lock" > /dev/null 2>&1
	assertEquals 'Migrate was not run' \
		"doctrine:migrations:migrate" \
		"$(cat "${SHUNIT_TMPDIR}/consoleArgs")"
}

testNoChangesWhenInvalidSchema()
{
	console()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/consoleArgs"
		return 1
	}
	touch "${SHUNIT_TMPDIR}/consoleArgs"
	export -f console
	export SHUNIT_TMPDIR
	initRepo
	mkdir --parents src/AppBundle/Entity
	echo "a" > src/AppBundle/Entity/someFile
	git add .
	git commit --quiet --message "let's commit someFile" > /dev/null 2>&1
	assertEquals 'Only validate was run' \
		"doctrine:schema:validate" \
		"$(cat "${SHUNIT_TMPDIR}/consoleArgs")"
}

initRepo()
{
	cd "$testRepo"
	rm --recursive --force .git
	git init --quiet .
	git config hooks.enabled-plugins php/doctrine
	git config hooks.doctrine.sf-executable console
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
