#!/bin/bash



echo "**** Init script started ****"

if [ ! -f "Musonn" ]; then
	"**** Musonn folder not found, cloning repo... ****"
	git clone -b $BRANCH https://github.com/NicolasFerec/Musonn.git
	cd Musonn
	echo "**** Done! ****"
else
	cd Musonn
	echo "**** Pulling repo... ****"
	git fetch origin
	git checkout $BRANCH
	git pull
	echo "**** Done! ****"
fi

cd app

echo "**** Installing / updating dependencies... ****"
composer install --no-interaction --optimize-autoloader
echo "**** Done! ****"

echo "**** Clearing cache... ****"
php bin/console cache:clear
echo "**** Done! ****"

echo "**** Migrating database... ****"
php bin/console doctrine:migration:migrate --no-interaction
echo "**** Done! ****"

echo "**** Starting web server... ****"
symfony server:start
echo "**** Done! ****"