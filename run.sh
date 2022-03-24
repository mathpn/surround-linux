#!/bin/bash

sinks=$(pacmd list-sinks | grep -e 'name:')

PS3="Choose a default sink: "
select sink in $(echo $sinks | sed "s/name: /\n/g" | sed "s/<//g" | sed "s/>//g")
do
    echo "Selected sink: $sink"
    break
done

file=9999
while ! [ -f "./data/hrir_listen/hrirs/hrir-$file.wav" ]
do
    read -p "Please choose a valid HRIR file number (check data/hrir_listen/hrirs, 0 for default): " file
    if [ $file -eq '0' ]
    then
        echo "Using default HRIR (hrir_kemar)"
        break
    fi
done


if [ $file -eq '0' ]
then
    file_path="./data/hrir_kemar/hrir-kemar.wav"
else
    file_path="./data/hrir_listen/hrirs/hrir-$file.wav"
fi

mkdir -p ~/.local/share/hrir
echo "Copying HRIR file to ~/.local/share/hrir/hrir.wav"
cp -a $file_path ~/.local/share/hrir/hrir.wav

config_file="$HOME/.config/pulse/default.pa"

if [ -f $config_file ]
then
    echo "$config_file already exists, continuing will overwrite any previous module-virtual-surround-sink configuration"
    read -r -p "Are you sure? [y/n] " response
    response=${response,,}
    if ! [[ "$response" =~ ^(yes|y)$ ]]
    then
        echo "exiting"
        exit 0
    fi
    echo "modifying config file: $config_file"
    grep -v "module-virtual-surround" $config_file > tmp_config && mv tmp_config $config_file
    echo "" >> $config_file
    echo "load-module module-virtual-surround-sink sink_name=vsurround sink_properties=device.description=VirtualSurround hrir=$HOME/.local/share/hrir/hrir.wav master=$sink" >> $config_file
else
    echo "creating config file: $config_file"
    touch $config_file
    echo "#!/usr/bin/pulseaudio -nF" >> $config_file
    echo "" >> $config_file
    echo ".include /etc/pulse/default.pa" >> $config_file
    echo "" >> $config_file
    echo "load-module module-virtual-surround-sink sink_name=vsurround sink_properties=device.description=VirtualSurround hrir=$HOME/.local/share/hrir/hrir.wav master=$sink" >> $config_file
fi

echo "Please reboot"
