#!/bin/bash
cd "$( dirname "$0" )"
for script in *
do
    if [ $script != "$( basename "$0" )" -a -f $script ]
    then
        ./$script
        echo "----------------------"
        echo "  "
    fi
done
*/*.sh
