#!/bin/sh

testIsSilentWhenCommitingSymlink()
{
    initRepo
    mkdir target
    ln -s target source
    git add source
    git commit -m "Let's commit a symlink" 1> /dev/null 2>${stderrF}
    assertFalse "unexpected output to STDERR : `cat ${stderrF}`" "[ -s '${stderrF}' ]"
}

testExitsWithCodeGreaterThanZeroWhenDetectingJunk()
{
    initRepo
    echo "junk" >> .git/hooks/junkchecker/junk-phrases
    echo "junk" > someFile
    git add someFile
    git commit -m "Let's commit something we shouldn't" 1> /dev/null 2>${stderrF}
    rtrn=$?
    assertEquals "The junkchecker didn't detect the junk" 1 $rtrn

}

testExitsWithCodeEqualToZeroWhenJunkIsNotInTheStagingArea()
{
    rm -rf .git
    initRepo
    echo "junk" >> .git/hooks/junkchecker/junk-phrases
    echo "test" > someFile
    git add someFile
    git commit -m "Let's commit a first file" 1> /dev/null 2>${stderrF}
    echo "test" > someOtherFile
    echo "junk" > someFile
    git add someOtherFile
    git commit -m "Let's commit something perfectly ok" 1> /dev/null 2>${stderrF}
    rtrn=$?
    assertEquals "The junkchecker should be ok with this commit" 0 $rtrn
}

testExitsWithCodeEqualToZeroWhenJunkIsNotInTheStagedPartOfAFile()
{
    rm -rf .git
    initRepo
    echo "junk" >> .git/hooks/junkchecker/junk-phrases
    echo "test" > someFile
    git add someFile
    echo "junk" >> someFile
    git commit -m "Let's commit something perfectly ok" 1> /dev/null 2>${stderrF}
    rtrn=$?
    assertEquals "The junkchecker should be ok with this commit" 0 $rtrn
}

initRepo()
{
    cd $testRepo
    git init -q .
    mv .git/hooks/junkchecker/junk-phrases.sample .git/hooks/junkchecker/junk-phrases
    git config hooks.enabled-plugins junkchecker
    git config hooks.junkchecker.phrasesfile .git/hooks/junkchecker/junk-phrases
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
