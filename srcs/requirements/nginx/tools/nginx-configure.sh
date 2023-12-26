#!/bin/sh

openssl req -x509 -nodes -out /etc/nginx/ssl/"$CERT_SSL" \
	-keyout /etc/nginx/ssl/"$KEY_SSL" \
	-subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=*"

###############################################################################

nginx -g "daemon off;"
