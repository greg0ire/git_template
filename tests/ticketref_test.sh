#!/bin/sh

testAddsTicketRefToStartOfCommitMsg()
{
	testRepo=$SHUNIT_TMPDIR/test_repo1
	mkdir -p "${testRepo}"
	cd "${testRepo}" || exit 1
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

testEnsureCommitMsgContainsOneTicketRef()
{
	testRepo=$SHUNIT_TMPDIR/test_repo2
	mkdir -p "${testRepo}"
	cd "${testRepo}" || exit 1
	git init --quiet .
	git config hooks.enabled-plugins ticketref
	git checkout -b ABC-1234-branch 2>/dev/null
	date > dummyFile
	git add dummyFile
	git commit --quiet --message "ABC-1234 Add dummyFile to repo"
	git log -1 | grep -E '^ABC-1234'
	rtrn=$?
	assertEquals "Single reference of ABC-1234 found within Commit " 1 $rtrn
}

testRefIsAddedasSuffixToCommit()
{
	testRepo=$SHUNIT_TMPDIR/test_repo3
	mkdir -p "${testRepo}"
	cd "${testRepo}" || exit 1
	git init --quiet .
	git config hooks.enabled-plugins ticketref
	git config hooks.ticketref.position "POST"
	git checkout -b ABC-1234-branch 2>/dev/null
	date > dummyFile
	git add dummyFile
	git commit --quiet --message "Add dummyFile to repo"
	git log -1 | grep -E 'Ref: ABC-1234$'
	rtrn=$?
	assertEquals "Reference of ABC-1234 found within Commit at the end " 0 $rtrn
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
