#!/bin/bash
. "$(dirname "$0")/../template/hooks/git_config_wrapper.sh"

testReturns2WhenKeyIsNotSet()
{
	get_hook_config not configured result_var required 2> /dev/null
	assertEquals "2 should be returned on key not set" 2 $?
}

testReturns1WhenMisused()
{
	get_hook_config missing argument required 2> /dev/null
	assertEquals "1 should be returned on key not set" 1 $?
}

testReturnsCanonicalCase()
{
	initRepo
	git config hooks.foo.bar baz
	get_hook_config foo bar return_value required > /dev/null
	assertEquals "0 should be return when everything is fine" 0 $?
	assertEquals "the return value is not correct" baz "$return_value"
}

testOptionalDoesNotOutputAnyThing()
{
	get_hook_config missing argument return_value optional 2> "$stderrF"
	assertEquals "$(cat "$stderrF") was output" "" "$(cat "$stderrF")"
}

testDefaultValue()
{
	get_hook_config missing value actual optional foo 2> "$stderrF"
	assertEquals "the return value should be foo" foo "$actual"
}

initRepo()
{
	cd "$testRepo"
	git init --quiet .
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
