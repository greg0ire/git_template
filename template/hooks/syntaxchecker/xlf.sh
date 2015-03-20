#!/bin/sh

type xmllint > /dev/null 2>&1
if [ $? -eq 0 ]
then
	xmllint $FILE > /dev/null
fi
