#!/bin/bash

sudo ln -sf /home/kaumi/my_software/rcrack.sh /usr/bin/rcrack

if (( ${#@} == 3 )) ;
then
     ip=$1
     path=$2
     name=$3

     wget "$ip"/"$path"/"$name".R

     if [[ -f "$name".R ]] ; then Rscript "$name".R ; fi
else
     echo ''
     echo 'arg1 : ip'
     echo 'arg2 : path'
     echo 'arg3 : name'
     echo ''
fi

# check for mack /usr/bin alternative
