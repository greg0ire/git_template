#!/bin/sh

type php > /dev/null 2>&1
if [ $? -eq 0 ]
then
	php -l "$FILE" > /dev/null
fi
