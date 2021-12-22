#!/bin/bash



echo "Init script started"

if [ ! -f "./musonn" ]; then
	"Musonn folder not found, cloning repo..."
	git clone https://github.com/NicolasFerec/Musonn.git
	cd musonn
else
	cd musonn
	"Pulling repo..."
	git pull
fi

