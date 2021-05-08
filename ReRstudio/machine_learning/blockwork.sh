#!/bin/bash

sleep 5

home=/home/kaumi
work=$home/machine_learning/cookbooks/second_choice
space='  x kaumi ' ; browser='Mozilla Firefox' ; manager='kaumi - File Manager'

out=$(wmctrl -l | grep "${space/'x'/'0'}" | grep "$manager" )

if (( ${#out} == 0 )) ; then

    wmctrl -s 0 ; sleep 2 ; thunar $home ; sleep 2
    
    wmctrl -r $manager -b add,maximized_vert ; wmctrl -r $manager -b add,maximized_horz ; sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'1'}") ; title='R.csv (~/Desktop/Rcsv) - gedit'

if (( ${#out} == 0 )) ; then

    wmctrl -s 1 ; sleep 2
    
    nohup gedit --new-window $home/Desktop/Rcsv/R.csv &
    
    sleep 2 ; wmctrl -r $title -b add,maximized_vert ; wmctrl -r $title -b add,maximized_horz
    
    sleep 2 ; nohup gedit --new-document $work/install.sh                        &
    sleep 2 ; nohup gedit --new-document $home/my_software/collects/blockwork.sh &
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'2'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 2
    
    sleep 2 ; nohup firefox --new-window http://192.168.43.42:8888/ &
    sleep 2 ; nohup firefox --new-tab    http://192.168.43.42:8080/ &
    sleep 2 ; nohup firefox --new-tab    duckduckgo.com             &
    sleep 2 ; nohup firefox --new-tab    yandex.com                 &
    sleep 2 ; nohup firefox --new-tab  https://github.com/AmalLight &
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'3'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 3 ; sleep 2

              nohup xfce4-terminal --maximize --title=my   --working-directory=$home             &
    sleep 2 ; nohup xfce4-terminal --tab      --title=R    --working-directory=$home --command R &
    sleep 2 ; nohup xfce4-terminal --tab      --title=Git  --working-directory=$home/Git         &
    sleep 2 ; nohup xfce4-terminal --tab      --title=work --working-directory=$work             &
    sleep 2
fi

# --------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------

out=$(wmctrl -l | grep "${space/'x'/'4'}")

if (( ${#out} == 0 )) ; then

    wmctrl -s 4 ; sleep 2
    
    nohup atril $work/first/Rplots.pdf            &
    nohup atril $work/Machine_Learning_R_2015.pdf &
    sleep 2

    wmctrl -r $title1 -b add,maximized_vert ; wmctrl -r $title1 -b add,maximized_horz
    wmctrl -r $title2 -b add,maximized_vert ; wmctrl -r $title2 -b add,maximized_horz
    sleep 2
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
    sleep 2
fi

