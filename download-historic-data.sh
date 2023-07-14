#!/bin//bash

if [ ! -f historic.zip ]
then
    wget -O historic.zip https://github.com/TREEcg/Blue-Bike-to-OSLO/archive/refs/heads/master.zip
fi

unzip -j historic.zip "Blue-Bike-to-OSLO-master/history/*" -d "historic_data"
