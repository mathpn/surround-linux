#!/bin/bash

# fix for some linux distros
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

addgroup $SUDO_USER audio
