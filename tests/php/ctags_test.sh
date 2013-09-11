#!/bin/sh
testTagsFileIsGeneratedOnCommit()
{
	touch foo
	git add foo
	git commit -qm "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
}

testTagsFileWorksWithSymfony1()
{
	git config hooks.php-ctags.project-type symfony1
	touch foo
	git add foo
	git commit -qm "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
}

testTagsFileWorksWithSymfony2()
{
	git config hooks.php-ctags.project-type symfony2
	touch foo
	git add foo
	git commit -qm "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
}



initRepo()
{
	rm -rf $testRepo
	mkdir $testRepo
	cd $testRepo
	git init -q .
	git config hooks.enabled-plugins php/ctags
}

setUp()
{
	initRepo
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
