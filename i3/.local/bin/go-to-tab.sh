#!/bin/bash

# Kill broken brotab clients
brotab clients | awk '/ERROR/{print $3}' | xargs kill -9

TAB_ID=$(brotab list | rofi -dmenu -i | cut -f1)
brotab activate --focused $TAB_ID
