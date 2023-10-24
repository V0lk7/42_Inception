#!bin/sh

cd wordpress/

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

php-fpm81 -FOR
