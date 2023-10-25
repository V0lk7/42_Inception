#!bin/sh

cd wordpress/

adduser -S "www"
addgroup -S "www"

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

chown -R www:www /wordpress

rm -rf /etc/php81/php-fpm.d/www.conf

cat << EOF > /etc/php81/php-fpm.d/www.conf
	[Aled]

	user = www
	group = www

	listen = 9000

	pm = dynamic
	pm.max_children = 10
	pm.start_servers = 3
	pm.min_spare_servers = 2
	pm.max_spare_servers = 5
EOF

php-fpm81 -FOR
