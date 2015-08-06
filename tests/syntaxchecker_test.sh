#!/bin/sh

testWarnsWhenCommittingSyntacticallyWrongFile()
{
	testRepo=$SHUNIT_TMPDIR/test_repo
	mkdir --parents "$testRepo"
	cd "$testRepo"
	git init --quiet .
	git config hooks.enabled-plugins syntaxchecker
	echo "<?php echo 'this is valid php';"> validFile.php
	git add validFile.php
	git commit --quiet --message "Let's commit a valid php file"
	rtrn=$?
	assertEquals "The syntaxchecker detected something" 0 $rtrn

	echo "<?php invalid piece of garbage" > invalidFile.php
	git add invalidFile.php
	git commit --quiet --message "Let's try to commit this piece of garbage" 2> /dev/null
	rtrn=$?
	assertEquals "The syntaxchecker did not detect the syntax error" 1 $rtrn
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. "$(which shunit2)"
