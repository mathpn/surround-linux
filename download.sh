#!/bin/bash

mkdir ./data

cd data
wget https://stuff.salscheider.org/hrir_kemar.tar.gz --no-check-certificate

if [ $? -ne 0 ]; then
    echo "download failed, exiting"
    exit 1
fi

wget https://stuff.salscheider.org/hrir_listen.tar.gz --no-check-certificate

if [ $? -ne 0 ]; then
    echo "download failed, exiting"
    exit 1
fi

for file in *.tar.gz
do 
    tar xzf "${file}" && rm "${file}"
done

echo "Download done."
