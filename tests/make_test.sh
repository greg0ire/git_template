#!/bin/sh

testExitsWithCodeGreaterWhenMakeFails()
{
	initRepo
	cat > Makefile <<MAKEFILE
my_target:
	false
MAKEFILE
	git add Makefile
	git commit --message "Let's commit the Makefile" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "Make failure was not detected" 1 $rtrn
}

testItSupportsSeveralTargets()
{
	initRepo
	cat << MAKEFILE > Makefile
my_target:
	echo "my_target" >> foo/result

my_other_target:
	echo "my_other_target" >> foo/result
MAKEFILE
	git config hooks.make.target "my_target my_other_target"
	git add Makefile
	mkdir foo
	cd foo || exit 1
	git commit --message "Let's commit the Makefile" 1> /dev/null 2> "${stderrF}"
	rtrn=$?
	assertEquals "Make ran successfully" 0 $rtrn
	assertTrue 'First target was not run' "grep my_target result"
	assertTrue 'Second target was not run' "grep my_other_target result"
}

initRepo()
{
	cd "$testRepo" || exit 1
	git init --quiet .
	git config hooks.enabled-plugins make
	git config hooks.make.target my_target
	git config hooks.make.on "pre-commit pre-push"
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
