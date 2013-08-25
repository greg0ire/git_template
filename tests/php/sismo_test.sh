#!/bin/sh

testIsRunOnCommit()
{
    php()
    {
        echo $1 $2 $3 $4 > "${SHUNIT_TMPDIR}/phpWasRun"
    }
    export -f php
    export SHUNIT_TMPDIR
    initRepo
    echo "a" > someFile
    git add someFile
    git commit -qm "Let's commit some file"
    assertEquals 'Sismo was not run properly' \
        "/some/path --quiet build some-slug" \
        "`cat ${SHUNIT_TMPDIR}/phpWasRun`"
}

initRepo()
{
    cd $testRepo
    rm -rf .git
    git init -q .
    git config hooks.enabled-plugins php/sismo
    git config hooks.php-sismo.path /some/path
    git config hooks.php-sismo.slug some-slug
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
