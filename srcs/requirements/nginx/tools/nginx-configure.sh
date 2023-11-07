#!/bin/sh

###############################################################################
#Setting up nginx environment

mv nginx.conf /etc/nginx/

###############################################################################
#Generating SSL certificate and key
#
mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -out /etc/nginx/ssl/"$CERT_SSL" \
	-keyout /etc/nginx/ssl/"$KEY_SSL" \
	-subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=jduval.42.fr"

###############################################################################

nginx -g "daemon off;"
