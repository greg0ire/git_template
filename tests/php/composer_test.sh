#!/bin/sh
testExistsWithCodeEqualToZeroWhenComposerJsonIsValid()
{
    initRepo
    composer init -n --name="awesome/project" --description="elaborate description"
    git add composer.json
    git commit -m "Let's commit a the composer.json" 1> /dev/null 2>${stderrF}
    rtrn=$?
    assertEquals "The valid composer.json did not pass" 0 $rtrn
}

testExitsWithCodeGreaterThanZeroWhenComposerJsonIsInvalid()
{
    initRepo
    echo "invalid json data" > composer.json
    git add composer.json
    git commit -m "Let's commit a the composer.json" 1> /dev/null 2>${stderrF}
    rtrn=$?
    assertEquals "The invalid composer.json passed" 1 $rtrn

}

initRepo()
{
    cd $testRepo
    git init -q .
    echo "plugins=(php/composer)" > .git/hooks/hooksrc
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
