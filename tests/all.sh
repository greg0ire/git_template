#!/bin/bash
cd "$( dirname "$0" )"
for script in * php/*
do
    if [ $script != "$( basename "$0" )" -a -f $script ]
    then
        ./$script
        if [ $? -ne 0 ]
        then
            exit 1
        fi
        echo "----------------------"
        echo "  "
    fi
done
