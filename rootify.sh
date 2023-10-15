#!/usr/bin/env bash


if [[ $UID -ne 0 ]] ; then
    echo "Please run as root!"
    exit 1
fi

EXECUTABLE=/home/ykitten/.nimble/bin/mybl


chown root $EXECUTABLE
chmod +s $EXECUTABLE
