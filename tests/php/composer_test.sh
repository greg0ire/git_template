#!/bin/bash
testExistsWithCodeEqualToZeroWhenComposerJsonIsValid()
{
	initRepo
	echo '{
	"name": "awesome/project",
	"description": "elaborate description",
	"license": "proprietary",
	"require": {

	}
}' > composer.json
	git add composer.json
	git commit --message "Let's commit a the composer.json" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The valid composer.json did not pass" 0 $rtrn
}

testExitsWithCodeGreaterThanZeroWhenComposerJsonIsInvalid()
{
	initRepo
	echo "invalid json data" > composer.json
	git add composer.json
	git commit --message "Let's commit a the composer.json" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The invalid composer.json passed" 1 $rtrn

}

testRunsComposerOnComposerLockCheckoutChange()
{
	composer()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/composerWasRun"
	}
	export -f composer
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > composer.lock
	git add composer.lock
	git commit --quiet --message "first version of composer.lock"
	echo "b" > composer.lock
	git add composer.lock
	git commit --quiet --message "second version of composer.lock"
	git checkout --quiet HEAD^
	assertTrue 'Composer was not run' "[ $(cat "${SHUNIT_TMPDIR}/composerWasRun") == install ]"
	git config hooks.composer.onChange just_warn
	git config hooks.notification.notifier testNotifier
	testNotifier()
	{
		touch "${SHUNIT_TMPDIR}/testNotifierWasRun"
	}
	export -f testNotifier
	git checkout --quiet main
	assertTrue 'testNotifier was not run' "[ -f ${SHUNIT_TMPDIR}/testNotifierWasRun ]"

	git config hooks.notification.notifier echo
	git commit --quiet --message "third version of composer.lock" > /dev/null
	git checkout --quiet 'HEAD@{1}' > "${SHUNIT_TMPDIR}/echoWasRun" 2>&1
	assertEquals 'echo was not run' 'You should run Composer!' "$(cat "${SHUNIT_TMPDIR}/echoWasRun")"
}

testRunsComposerOnPostMerge()
{
	composer()
	{
		echo "$1" > "${SHUNIT_TMPDIR}/composerWasRun"
	}
	export -f composer
	export SHUNIT_TMPDIR
	initRepo
	echo "" > "${SHUNIT_TMPDIR}/composerWasRun"
	echo "a" > composer.lock
	git add composer.lock
	git commit --quiet --message "first version of composer.lock"
	cd ..
	git clone --quiet test_repo test_repo2
	cd test_repo2
	git config hooks.enabled-plugins php/composer
	git config hooks.composer.onChange run
	touch someFile
	git add someFile
	git commit --quiet --message "someFile"
	cd ../test_repo
	echo "b" > composer.lock
	git add composer.lock
	git commit --quiet --message "second version of composer.lock"
	cd - > /dev/null
	export GIT_MERGE_AUTOEDIT=no
	git config pull.rebase false
	git pull --quiet > /dev/null 2>&1
	assertTrue 'Composer was not run' "[ $(cat "${SHUNIT_TMPDIR}/composerWasRun") == install ]"
	cd - > /dev/null
	echo "c" > composer.lock
	git add composer.lock
	git commit --quiet --message "third version of composer.lock"
	cd - > /dev/null
	git config hooks.composer.onChange just_warn
	git config hooks.notification.notifier testNotifier
	testNotifier()
	{
		touch "${SHUNIT_TMPDIR}/testNotifierWasRun"
	}
	export -f testNotifier
	git pull --quiet --no-edit > /dev/null 2>&1
	assertTrue 'testNotifier was not run' "[ -f ${SHUNIT_TMPDIR}/testNotifierWasRun ]"
}


initRepo()
{
	cd "$testRepo"
	rm --recursive --force .git
	git init --quiet .
	git config hooks.enabled-plugins php/composer
	git config hooks.composer.onChange run
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
