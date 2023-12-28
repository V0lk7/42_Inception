#!/bin/sh

openssl req -x509 -nodes -out /etc/nginx/ssl/jduval.42.fr.crt \
	-keyout /etc/nginx/ssl/jduval.42.fr.key \
	-subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=*"

###############################################################################

nginx -g "daemon off;"
