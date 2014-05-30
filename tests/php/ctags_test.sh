#!/bin/sh
testTagsFileIsGeneratedOnCommit()
{
	touch foo
	git add foo
	git commit --quiet --message "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
}

testTagsFileWorksWithSymfony1()
{
	git config hooks.php-ctags.project-type symfony1
	git config hooks.php-ctags.tag-kinds cfiv
	echo '<?php $indexMe = 42;' > foo.php
	mkdir cache
	echo '<?php $doNotIndexMe = 42;' > cache/bar.php
	git add foo.php
	git commit --quiet --message "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
	assertTrue "\$indexMe was not found here : `cat .git/tags`" "grep indexMe .git/tags"
	assertFalse '$doNotIndexMe was found' "grep doNotIndexMe .git/tags"
}

testTagsFileWorksWithSymfony2()
{
	git config hooks.php-ctags.project-type symfony2
	git config hooks.php-ctags.tag-kinds cfiv
	echo '<?php $indexMe = 42;' > foo.php
	mkdir --parents app/cache
	echo '<?php $doNotIndexMe = 42;' > app/cache/bar.php
	git add foo.php
	git commit --quiet --message "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
	assertTrue "\$indexMe was not found here : `cat .git/tags`" "grep indexMe .git/tags"
	assertFalse '$doNotIndexMe was found' "grep doNotIndexMe .git/tags"
}


testTagsFileOptions()
{
	git config hooks.php-ctags.tag-kinds cfi # do not index variables
	echo '<?php $variable = 42;' > foo.php
	git add foo.php
	git commit --quiet --message "foo file"
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
	assertFalse "\$variable was found" "grep variable .git/tags"

	git config hooks.php-ctags.tag-kinds cfiv # index variables
	git commit --amend --message 'foo file #2'
	sleep 1 # ctags is run in the background. Wait for it.
	assertTrue "\$variable was not found" "grep variable .git/tags"
}



initRepo()
{
	rm --recursive --force $testRepo
	mkdir $testRepo
	cd $testRepo
	git init --quiet .
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
	mkdir --parents $testRepo
}

[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. `which shunit2`
