#!/bin/bash 
# Remove title bar
xdotool keydown Super
xdotool key u
xdotool keyup Super

# Center align and set padding for windows 
# xdotool keydown Super
# xdotool key g
# xdotool keyup Super
# xdotool key Right
# xdotool key Right
# xdotool key Down 
# xdotool key Return 
# xdotool key Escape 

fw=`xdotool getwindowfocus`
xdotool windowsize "$fw" 97% 91%

IFS='x' read screenWidth screenHeight < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

newPosX=$((screenWidth/2-width/2))
newPosY=$((screenHeight/2 - height/2 - 25))

xdotool getactivewindow windowmove "$newPosX" "$newPosY"
# xdotool windowsize 90% 90%

# session need to be unique. so using folder name
folder=${PWD##*/}
tmux new-session -d -s $folder -n $folder 
tmux new-window -a -n fish -t $folder 
tmux send-keys -t $folder:$folder "lvim ." Enter
tmux -u attach -t $folder:$folder
