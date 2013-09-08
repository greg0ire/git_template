#!/bin/bash
testExistsWithCodeEqualToZeroWhenComposerJsonIsValid()
{
	initRepo
	echo '{
	"name": "awesome/project",
	"description": "elaborate description",
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
}

initRepo()
{
	cd $testRepo
	rm -rf .git
	git init -q .
	git config hooks.enabled-plugins php/composer
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
