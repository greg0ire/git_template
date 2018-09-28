#!/bin/sh

testAddsTicketRefToStartOfCommitMsg()
{
	testRepo=$SHUNIT_TMPDIR/test_repo1
	mkdir -p "${testRepo}"
	cd "${testRepo}"
	git init --quiet .
	git config --add hooks.enabled-plugins ticketref
	git checkout -b ABC-1234-branch 2>/dev/null
	date > dummyFile
	git add dummyFile
	git commit --quiet --message "Add dummyFile to repo"
	git log -1 | grep 'ABC-1234'
	rtrn=$?
	assertEquals "ABC-1234 found within Commit " 0 $rtrn
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
