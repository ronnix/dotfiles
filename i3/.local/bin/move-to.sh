#!/bin/bash
WINDOW=$(i3-msg -t get_tree | jq '..|select(.focused?==true)|.id')
WORKSPACE=$(i3-msg -t get_workspaces | jq -r .[].name | rofi -dmenu)
i3-msg "[con_id=$WINDOW] move window to workspace $WORKSPACE"
if [ "$1" == "--go" ]; then
    i3-msg "workspace $WORKSPACE"
fi
