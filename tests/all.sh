#!/bin/bash
if [ -f .git/hooks/configure.sh ]
then
	echo "Huh ? Copy failed or what ?"
	ls .git/hooks
	ls "$(git config --path --get init.templatedir)"
	exit 1
fi
cd "$( dirname "$0" )"
for script in * php/*
do
	if [ "$script" != "$( basename "$0" )" -a -f "$script" ]
	then
		"./$script"
		if [ $? -ne 0 ]
		then
			exit 1
		fi
		echo "----------------------"
		echo "  "
	fi
done
