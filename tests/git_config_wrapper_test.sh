#!/bin/bash
. `dirname $0`/../hooks/git_config_wrapper.sh

testReturns2WhenKeyIsNotSet()
{
	get_hook_required_config not configured result_var 2> /dev/null
	assertEquals "2 should be returned on key not set" 2 $?
}

testReturns1WhenMisused()
{
	get_hook_required_config missing argument 2> /dev/null
	assertEquals "1 should be returned on key not set" 1 $?
}

testReturnsCanonicalCase()
{
	initRepo
	git config hooks.foo.bar baz
	get_hook_required_config foo bar return_value > /dev/null
	assertEquals "0 should be return when everything is fine" 0 $?
	assertEquals "the return value is not correct" baz $return_value
}

initRepo()
{
	cd $testRepo
	git init -q .
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
