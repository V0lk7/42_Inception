#!/bin/sh

apk update && apk upgrade
apk add nginx
apk add openssl

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -out /etc/nginx/ssl/inception_certificat.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/S=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=jduval.42.fr/EA=jduval@student.42angouleme.com"

