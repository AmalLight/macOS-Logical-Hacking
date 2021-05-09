#!/bin/bash

sleep 6

home=/home/kaumi
work=$home/machine_learning/cookbooks/second_choice
space='  x kaumi ' ; manager='kaumi - File Manager'

out=$(wmctrl -l | grep "${space/'x'/'0'}" | grep "$manager" )

if (( ${#out} == 0 )) ; then

    wmctrl -s 0 ; sleep 2 ; thunar $home ; sleep 2
    
    wmctrl -r $manager -b add,maximized_vert ; wmctrl -r $manager -b add,maximized_horz ; sleep 2
    
    thunar $work ; thunar $home/Git ; thunar $home/my_software/collects ;
    
    thunar $home/Desktop/Rcsv ; sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'1'}") ; title='R.csv (~/Desktop/Rcsv) - gedit'

if (( ${#out} == 0 )) ; then

    wmctrl -s 1 ; sleep 2 ; nohup gedit --new-window $home/Desktop/Rcsv/R.csv &
    
    sleep 2 ; wmctrl -r $title -b add,maximized_vert ; wmctrl -r $title -b add,maximized_horz
    sleep 2
    
    nohup gedit --new-document $work/install.sh                        &
    nohup gedit --new-document $home/my_software/collects/blockwork.sh &
    
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'2'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 2
    
    sleep 2 ; nohup firefox --new-window http://192.168.43.42:8888/ &
    sleep 3 ; nohup firefox --new-tab    http://192.168.43.42:8080/ &
    sleep 3 ; nohup firefox --new-tab    duckduckgo.com             &
    sleep 3 ; nohup firefox --new-tab    yandex.com                 &
    sleep 3 ; nohup firefox --new-tab  https://github.com/AmalLight &
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'3'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 3 ; sleep 2

    nohup xfce4-terminal --maximize --title=my   --working-directory=$home &
    sleep 2
    
    nohup xfce4-terminal --tab --title=R    --working-directory=$home --command R &
    nohup xfce4-terminal --tab --title=Git  --working-directory=$home/Git         &
    nohup xfce4-terminal --tab --title=work --working-directory=$work             &
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'4'}") ; title='Atril Document Viewer'

if (( ${#out} == 0 )) ; then

    wmctrl -s 4 ; sleep 2 ; nohup atril &

    sleep 2 ; wmctrl -r $title -b add,maximized_vert ; wmctrl -r $title -b add,maximized_horz ; sleep 2
    
    nohup atril $work/first/Rplots.pdf            &
    nohup atril $work/Machine_Learning_R_2015.pdf &
    sleep 3
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'5'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 5 ; sleep 2 ; nohup firefox --new-window &
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'6'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 6 ; sleep 2 ; nohup firefox --new-window https://www.simosnap.org/chat &
    sleep 4 ; nohup firefox --new-tab https://webchat.freenode.net/ &
    sleep 4 ; nohup firefox --new-tab https://webchat.azzurra.org/  &
    sleep 4
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'7'}") ; title='VLC media player'

if (( ${#out} == 0 )) ; then

    wmctrl -s 7 ; sleep 2 ; nohup vlc &
    
    sleep 2 ; wmctrl -r $title -b add,maximized_vert ; wmctrl -r $title -b add,maximized_horz
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'8'}") ; title='Diagram1.dia (/home/kaumi) - dia'

if (( ${#out} == 0 )) ; then

    wmctrl -s 8 ; sleep 2 ; nohup dia &
    
    sleep 2 ; wmctrl -r $title -b add,maximized_vert ; wmctrl -r $title -b add,maximized_horz
    sleep 2
fi

