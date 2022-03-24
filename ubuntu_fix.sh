#!/bin/bash

# fix for ubuntu 20.04 and possibly other systems
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

addgroup $SUDO_USER audio
