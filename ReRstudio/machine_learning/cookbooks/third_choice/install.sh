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
            
            sudo Rscript -e 'install.packages ( "ggplot2"        )'
            sudo Rscript -e 'install.packages ( "corrplot"       )'
            sudo Rscript -e 'install.packages ( "rsample"        )'
            sudo Rscript -e 'install.packages ( "doMC"           )'
            sudo Rscript -e 'install.packages ( "caret"          )'
            sudo Rscript -e 'install.packages ( "devtools"       )'
            sudo Rscript -e 'install.packages ( "randomForest"   )'
            sudo Rscript -e 'install.packages ( "mlbench"        )'
            sudo Rscript -e 'install.packages ( "gbm"            )'
            sudo Rscript -e 'install.packages ( "xgboost"        )'
            sudo Rscript -e 'install.packages ( "caretEnsemble"  )'
            sudo Rscript -e 'install.packages ( "klaR"           )'
            sudo Rscript -e 'install.packages ( "kernlab"        )'
            sudo Rscript -e 'install.packages ( "kernlab"        )'
            sudo Rscript -e 'install.packages ( "recommenderlab" )'
            
            sudo Rscript -e 'library ( devtools ) ; install_github( "topepo/caret/pkg/caret" )'

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
