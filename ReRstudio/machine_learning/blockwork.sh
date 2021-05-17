#!/bin/bash

sleep 6 ; end ;

home=/home/kaumi
work=$home/machine_learning/cookbooks/second_choice
user=kaumi ; space="  x $user " ; start='0x00e00003'"$space"
manager="$user - File Manager" ; browser=Firefox

wmctrl_filtered() {

    number="$1" ; filter="$2"
    
    out=`wmctrl -l | grep "${space/'x'/$number}" | grep "$filter"`
    
    skip=${#start} ; echo "${out:skip:9999}"
}

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 0 "$manager"`

if (( ${#out} == 0 )) ; then

    wmctrl -s 0

    sleep 2 ; thunar $home
    sleep 2 ; out=`wmctrl_filtered 0 "$manager"`
    
    wmctrl -r $out -b add,maximized_vert ; wmctrl -r $out -b add,maximized_horz
    
    sleep 2 ; thunar $work $home/Git $home/my_software/collects $home/Desktop/Rcsv
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 1 gedit`

if (( ${#out} == 0 )) ; then

    wmctrl -s 1

    sleep 2 ; nohup gedit --new-window $home/Desktop/Rcsv/R.csv &
    sleep 2 ; out=`wmctrl_filtered 1 gedit`
    
    wmctrl -r $out -b add,maximized_vert ; wmctrl -r $out -b add,maximized_horz ; 
    
    sleep 2 ; nohup gedit --new-document $work/install.sh \
                                         $home/my_software/collects/blockwork.sh &
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 3 Terminal`
out=$out`wmctrl_filtered 3 R`
out=$out`wmctrl_filtered 3 Git`
out=$out`wmctrl_filtered 3 work`

if (( ${#out} == 0 )) ; then

    wmctrl -s 3

    sleep 2 ; xfce4-terminal --maximize --title=my --working-directory=$home
    sleep 2

    xfce4-terminal --tab --title=R    --working-directory=$home --command R
    xfce4-terminal --tab --title=Git  --working-directory=$home/Git
    xfce4-terminal --tab --title=work --working-directory=$work

    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 4 Atril`
out=$out`wmctrl_filtered 4 pdf`

if (( ${#out} == 0 )) ; then

    wmctrl -s 4

    sleep 2 ; nohup atril &
    sleep 2 ; out=`wmctrl_filtered 4 Atril`
    
    wmctrl -r $out -b add,maximized_vert ; wmctrl -r $out -b add,maximized_horz
    
    sleep 2 ; nohup atril $work/first/Rplots.pdf $work/Machine_Learning_R_2015.pdf &
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 7 VLC`

if (( ${#out} == 0 )) ; then

    wmctrl -s 7

    sleep 2 ; nohup vlc &
    sleep 2 ; out=`wmctrl_filtered 7 VLC`
    
    wmctrl -r $out -b add,maximized_vert ; wmctrl -r $out -b add,maximized_horz ; sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 8 dia`

if (( ${#out} == 0 )) ; then

    wmctrl -s 8

    sleep 2 ; nohup dia &
    sleep 2 ; out=`wmctrl_filtered 8 dia`
    
    wmctrl -r $out -b add,maximized_vert ; wmctrl -r $out -b add,maximized_horz ; sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

sniffing_and_wait( ) {

    while ( true ) ;
    do
        out=`sudo timeout 3 tcpdump -n | grep '443 > '`
        # i can't send with 443 , so i can only recive from other by 443 , so i am downloading
        
        if (( ${#out} == 0 )) ;
        then
            return 0
        else
            echo $out
            sleep 1
        fi

    done
}


# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 2 "$browser"` # browser

if (( ${#out} == 0 )) ; then

    wmctrl -s 2

    sleep 2 ; nohup firefox --new-window http://192.168.43.42:8888/ &
    sleep 4 ; nohup firefox --new-tab    http://192.168.43.42:8080/ &
    sleep 4
                        nohup firefox --new-tab https://duckduckgo.com/      &
    sniffing_and_wait ; nohup firefox --new-tab https://yandex.com/          &
    sniffing_and_wait ; nohup firefox --new-tab https://github.com/AmalLight &
    sniffing_and_wait ; nohup firefox --new-tab https://unblockit.link/      &
    sniffing_and_wait ; nohup firefox --new-tab https://app.diagrams.net/    &
    sniffing_and_wait ; nohup firefox --new-tab https://web.whatsapp.com/    &
    sniffing_and_wait
fi
    
# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 5 "$browser"` # music

if (( ${#out} == 0 )) ; then

    wmctrl -s 5

    sleep 2 ; nohup firefox --new-window &
    sleep 4
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=`wmctrl_filtered 6 "$browser"` # chat

if (( ${#out} == 0 )) ; then

    wmctrl -s 6

    sleep 2 ; nohup firefox --new-window https://simosnap.org/chat &
    
    sniffing_and_wait ; nohup firefox --new-tab https://webchat.freenode.net/ &
    sniffing_and_wait ; nohup firefox --new-tab https://webchat.azzurra.org/  &
    sniffing_and_wait ; nohup firefox --new-tab https://translate.yandex.com/ &
    sniffing_and_wait ;
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

read -p 'press enter for finish'

