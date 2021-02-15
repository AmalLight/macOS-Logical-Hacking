#!/bin/bash

if (( ${#@} >= 2 ));
then
    echo ''
    echo 'searching'
    echo ''

    searchfor $@
    
    collect=`searchfor $@`
    rm -rf $collect ; sync
    
    echo ''
    echo 'delted'
    echo ''
else
   echo ''
   echo 'arg1 : directory'
   echo 'arg2 : word/words to delete'
   echo ''
fi;
