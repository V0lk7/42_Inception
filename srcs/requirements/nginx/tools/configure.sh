#!/bin/sh

apk update && apk upgrade
apk add nginx
apk add openssl

###############################################################################
#Setting up nginx environment

NGINX_CONF=/etc/nginx/nginx.conf
USER_NGINX=www

if [ -f "$NGINX_CONF" ]; then
	rm -rf "$NGINX_CONF"
fi

mv nginx.conf /etc/nginx/

adduser -D -g "" "$USER_NGINX"

chown -R www:www /var/lib/nginx
chown -R www:www /var/www

mkdir -p /etc/nginx/ssl

###############################################################################
#Generating SSL certificate and key

openssl req -x509 -nodes -out /etc/nginx/ssl/jduval.42.fr.crt \
	-keyout /etc/nginx/ssl/jduval.42.fr.key \
	-subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=jduval.42.fr"

###############################################################################

nginx -g "daemon off;"
