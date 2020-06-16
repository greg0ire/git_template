#!/bin/sh

testWarnsWhenPushingWIPCommits()
{
	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents "$testRepo"
	cd "$testRepo"
	git init --quiet --bare .
	cd ..
	mkdir other_repo
	cd other_repo
	git init --quiet .
	git config hooks.enabled-plugins wipchecker
	touch dummyFile
	git add dummyFile
	git remote add origin ../test_repo
	git commit --quiet --message "WIP dummyFile is not finished"
	git push -u origin main 1>/dev/null 2>&1
	rtrn=$?
	assertEquals "The wipchecker didn't detect a WIP commit" 1 $rtrn
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
