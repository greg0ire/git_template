#!/bin/sh

testIsSilentWhenCommitingSymlink()
{
    cd $testRepo
    git init .
    mv .git/hooks/hooksrc.sample .git/hooks/hooksrc
    mv .git/hooks/junkchecker/junk-phrases.sample .git/hooks/junkchecker/junk-phrases
    mkdir target
    ln -sv target source
    git add source
    git commit -m "Let's commit a symlink" 2>${stderrF}
    assertFalse "unexpected output to STDERR : `cat ${stderrF}`" "[ -s '${stderrF}' ]"
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
. ~/shunit2/shunit2
