#!/bin/bash

if (( ${#@} >= 2 ));
then
   foldr="$1"
   files="$@"
   
   for el in $files;
   do
      if [[ ! $el == $foldr ]]; then find $foldr | grep $el ; fi
   done

else
   echo ''
   echo 'arg1 : directory'
   echo 'arg2 : word/words'
   echo ''

fi;
