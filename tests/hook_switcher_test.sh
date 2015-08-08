#!/bin/bash
. "$(dirname "$0")/../template/hooks/hook_switcher.sh"

testHookIsEnabled()
{
	initRepo
	hook_is_enabled some_hook
	assertEquals 'some_hook should be disabled' 1 $?
	yes | switch_hook some_hook
	hook_is_enabled some_hook
	assertEquals 'some_hook should be enabled' 0 $?
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

	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents "$testRepo"
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
