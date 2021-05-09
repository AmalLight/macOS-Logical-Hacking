#!/bin/bash

enable=false

if (( ${#@} == 1 || ${#@} ==  2 )) ; then enable=true ; fi

if $enable ;
then

    if (( ${#@} == 1 )) ;
    then

        requirements=$1

        if [[ "$requirements" == "yes" ]] ;
        then
        
            sudo apt install -y python3 r-base python3-pip python3-virtualenv \
                                python3-keras  python3-tensorflow \
                                \
                                libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 \
                                libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
                                
            bash Anaconda3-2020.11-Linux-x86_64.sh -b -p $HOME/anaconda

            eval "$(/home/kaumi/anaconda/bin/conda shell.bash hook)"

            conda init ; conda config --set auto_activate_base false
            
            conda update -n base -c defaults conda

            sudo Rscript -e 'install.packages( "keras" )'
            sudo Rscript -e 'install.packages( "tensorflow" )'

            Rscript -e '

                library( keras )

                install_keras (
        
                    method = c ( "auto" , "virtualenv" , "conda" ) ,
                    conda = "auto" ,
                    version = "default" ,
                    tensorflow = "default" ,
                    extra_packages = c ( "tensorflow-hub" )
                )
            '
            
            # Set the tensorflow argument's value to gpu:
            # tensorflow = "gpu". This command will install the GPU version of keras in R.
            
        else
            enable=false
        fi
            
    else
    
        dir=$1 ; file=$2
        
        Rscript ./"$dir"/"$file".R
    
    fi
fi

if ! $enable ;
then
    echo ''
    echo 'arg 1 : install all requirements = [yes/..]'
    echo 'OR'
    echo 'arg 2 : Directory'
    echo 'arg 3 : File.R inside Directory'
    echo ''
fi
