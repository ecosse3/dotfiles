#!/bin/sh

if ! updates=$(yay -Qu --aur 2> /dev/null | grep -v local | wc -l ); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo $updates
else
    echo "0"
fi
