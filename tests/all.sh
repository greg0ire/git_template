#!/bin/bash
cd "$( dirname "$0" )"
for script in *
do
    if [ $script != "$( basename "$0" )" ]
    then
        ./$script
    fi
done
*/*.sh
