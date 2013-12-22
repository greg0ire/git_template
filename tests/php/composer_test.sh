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
	git commit -m "Let's commit a the composer.json" 1> /dev/null 2>${stderrF}
	rtrn=$?
	assertEquals "The valid composer.json did not pass" 0 $rtrn
}

testExitsWithCodeGreaterThanZeroWhenComposerJsonIsInvalid()
{
	initRepo
	echo "invalid json data" > composer.json
	git add composer.json
	git commit -m "Let's commit a the composer.json" 1> /dev/null 2>${stderrF}
	rtrn=$?
	assertEquals "The invalid composer.json passed" 1 $rtrn

}

testRunsComposerOnComposerLockCheckoutChange()
{
	composer()
	{
		echo $1 > "${SHUNIT_TMPDIR}/composerWasRun"
	}
	export -f composer
	export SHUNIT_TMPDIR
	initRepo
	echo "a" > composer.lock
	git add composer.lock
	git commit -qm "first version of composer.lock"
	echo "b" > composer.lock
	git add composer.lock
	git commit -qm "second version of composer.lock"
	git checkout -q HEAD^
	assertTrue 'Composer was not run' "[ `cat ${SHUNIT_TMPDIR}/composerWasRun` == "install" ]"
	git config hooks.composer.onChange just_warn
	git config hooks.notification.notifier notify-send
	notify-send()
	{
		touch "${SHUNIT_TMPDIR}/notifySendWasRun"
	}
	export -f notify-send
	git checkout -q master
	assertTrue 'notify-send was not run' "[ -f ${SHUNIT_TMPDIR}/notifySendWasRun ]"

	git config hooks.notification.notifier echo
	git commit -qm "third version of composer.lock" > /dev/null
	git checkout -q HEAD@{1} > ${SHUNIT_TMPDIR}/echoWasRun 2>&1
	assertEquals 'echo was not run' 'You should run Composer!' "`cat ${SHUNIT_TMPDIR}/echoWasRun`"
}

testRunsComposerOnPostMerge()
{
	composer()
	{
		echo $1 > "${SHUNIT_TMPDIR}/composerWasRun"
	}
	export -f composer
	export SHUNIT_TMPDIR
	initRepo
	echo "" > "${SHUNIT_TMPDIR}/composerWasRun"
	echo "a" > composer.lock
	git add composer.lock
	git commit -qm "first version of composer.lock"
	cd ..
	git clone -q test_repo test_repo2
	cd test_repo2
	git config hooks.enabled-plugins php/composer
	git config hooks.composer.onChange run
	touch someFile
	git add someFile
	git commit -qm "someFile"
	cd ../test_repo
	echo "b" > composer.lock
	git add composer.lock
	git commit -qm "second version of composer.lock"
	cd - > /dev/null
	export GIT_MERGE_AUTOEDIT=no
	git pull -q > /dev/null 2>&1
	assertTrue 'Composer was not run' "[ `cat ${SHUNIT_TMPDIR}/composerWasRun` == "install" ]"
	cd - > /dev/null
	echo "c" > composer.lock
	git add composer.lock
	git commit -qm "third version of composer.lock"
	cd - > /dev/null
	git config hooks.composer.onChange just_warn
	git config hooks.notification.notifier notify-send
	notify-send()
	{
		touch "${SHUNIT_TMPDIR}/notifySendWasRun"
	}
	export -f notify-send
	git pull -q --no-edit > /dev/null 2>&1
	assertTrue 'notify-send was not run' "[ -f ${SHUNIT_TMPDIR}/notifySendWasRun ]"
}


initRepo()
{
	cd $testRepo
	rm -rf .git
	git init -q .
	git config hooks.enabled-plugins php/composer
	git config hooks.composer.onChange run
}

oneTimeSetUp()
{
	outputDir="${SHUNIT_TMPDIR}/output"
	mkdir "${outputDir}"
	stdoutF="${outputDir}/stdout"
	stderrF="${outputDir}/stderr"

	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir -p $testRepo
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. ~/src/shunit2/shunit2
