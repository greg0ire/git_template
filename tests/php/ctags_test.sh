#!/bin/sh
testTagsFileIsGeneratedOnCommit()
{
    initRepo
    touch foo
    git add foo
    git commit -qm "foo file"
    sleep 1 # ctags is run in the background. Wait for it.
    assertTrue 'The tags file was not generated' "[ -f .git/tags ]"
}


initRepo()
{
    cd $testRepo
    git init -q .
    git config hooks.enabled-plugins php/ctags
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
