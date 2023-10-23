#!/bin/sh

###############################################################################
#Setting up nginx environment

NGINX_CONF=/etc/nginx/nginx.conf

if [ -f "$NGINX_CONF" ]; then
	rm -rf "$NGINX_CONF"
fi

mv nginx.conf /etc/nginx/

adduser -D -g "" "$USER_NGINX"

chown -R www:www /var/lib/nginx
chown -R www:www /var/www

###############################################################################
#Generating SSL certificate and key
#
mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -out /etc/nginx/ssl/"$CERT_SSL" \
	-keyout /etc/nginx/ssl/"$KEY_SSL" \
	-subj "/C=FR/ST=Nouvelle-Aquitaine/L=Angouleme/O=42/OU=42/CN=jduval.42.fr"

###############################################################################

nginx -g "daemon off;"
