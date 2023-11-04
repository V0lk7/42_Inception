#!bin/sh

cd wordpress/

adduser -S "nginx"
addgroup -S "nginx"

sleep 5

wp core download
wp config create --dbname="$DATABASE_NAME" \
		 --dbuser="$WPADMIN_USERNAME" \
		 --dbpass="$WPADMIN_PASSWORD" \
		 --dbhost="mariadb" \
		 --skip-check

wp core install --url="$URL" \
		--title="$TITLE" \
		--admin_user="$WPADMIN_USERNAME" \
		--admin_password="$WPADMIN_PASSWORD" \
		--admin_email="jduval@student.42angouleme.fr" \
		--skip-email

#chown -R nginx:nginx /wordpress

rm -rf /etc/php81/php-fpm.d/www.conf

mv /www.conf /etc/php81/php-fpm.d/

php-fpm81 -FOR
