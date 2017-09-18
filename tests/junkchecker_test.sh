#!/bin/sh

testIsSilentWhenCommitingSymlink()
{
	initRepo
	mkdir target
	ln --symbolic target source
	git add source
	git commit --message "Let's commit a symlink" 1> /dev/null 2> "${stderrF}"
	assertFalse "unexpected output to STDERR : $(cat "${stderrF}")" "[ -s '${stderrF}' ]"
}

testExitsWithCodeGreaterThanZeroWhenDetectingJunk()
{
	initRepo
	echo "junk" > junk-phrases
	echo "junk" > someFile
	git add someFile
	git commit --message "Let's commit something we shouldn't" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The junkchecker didn't detect the junk" 1 $rtrn

}

testExitsWithCodeEqualToZeroWhenJunkIsNotInTheStagedPartOfAFile()
{
	rm --recursive --force .git
	initRepo
	echo "junk" > junk-phrases
	echo "test" > someFile
	git add someFile
	echo "junk" >> someFile
	git commit --message "Let's commit something perfectly ok" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The junkchecker should be ok with this commit" 0 $rtrn
}

testExitsWithCodeEqualToZeroWhenJunkIsRemovedAndNotAdded()
{
	initRepo
	echo "junk" > junk-phrases
	echo "junk" > someFile
	git add someFile
	git commit --no-verify --message "Let's commit something we shouldn't" 1> /dev/null 2>/dev/null
	echo "" > someFile
	git add someFile
	git commit --message "Let's remove some junk" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The junkchecker should be ok with this commit" 0 $rtrn
}

testMultiWordPattern()
{
	initRepo
	echo "var_dump" > junk-phrases
	echo "remove this debug line" >> junk-phrases
	echo "// TODO remove this debug line" > someFile
	git add someFile
	git commit --message "Let's commit something we shouldn't" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "The junkchecker detected the junk" 1 $rtrn
}

initRepo()
{
	cd "$testRepo"
	git init --quiet .
	git config hooks.enabled-plugins junkchecker
	git config hooks.junkchecker.phrasesfile junk-phrases
	echo "" > junk-phrases
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
