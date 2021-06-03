#!/bin/bash

enable=false ; if (( ${#@} == 1 || ${#@} ==  2 )) ; then enable=true ; fi

if $enable ;
then

    if (( ${#@} == 1 )) ;
    then

        requirements=$1

        if [[ "$requirements" == "yes" ]] ;
        then
            sudo apt install -y r-base
            
            sudo Rscript -e 'install.packages ( "e1071"     )'
            sudo Rscript -e 'install.packages ( "WriteXLS"  )'
            sudo Rscript -e 'install.packages ( "ggplot2"   )'
            sudo Rscript -e 'install.packages ( "reshape2"  )'
            sudo Rscript -e 'install.packages ( "stringr"   )'
            sudo Rscript -e 'install.packages ( "party"     )'
            sudo Rscript -e 'install.packages ( "caret"     )'
            sudo Rscript -e 'install.packages ( "car"       )'
            sudo Rscript -e 'install.packages ( "rpart"     )'
            sudo Rscript -e 'install.packages ( "modeldata" )'
            sudo Rscript -e 'install.packages ( "class"     )'

        else
            enable=false
        fi
            
    else
        dir=$1 ; file=$2 ;
        
        cd $dir ; Rscript ./"$file".R
        cd ..
    fi
fi

if ! $enable ;
then
    echo ''
    echo 'arg 1 : install all requirements = [yes/..]'
    echo 'OR'
    echo 'arg 1 : Directory'
    echo 'arg 2 : File.R inside Directory'
    echo ''
fi
