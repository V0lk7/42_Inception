#!bin/sh

Create_config(){
	wp config create --dbname="$DATABASE_NAME" \
			 --dbuser="$WPADMIN_USERNAME" \
			 --dbpass="$WPADMIN_PASSWORD" \
			 --dbhost="mariadb" \
			 --skip-check

	wp core install --url="$URL" \
			--title="$TITLE" \
			--admin_user="$WPADMIN_USERNAME" \
			--admin_password="$WPADMIN_PASSWORD" \
			--admin_email="Aled@student.42DuPerou.fr" \
			--skip-email

	wp user create	$WP_USERNAME $WP_USERNAME@aled.com --user_pass=$WP_PASSWORD --quiet
}

[ ! -f "wp-activate.php" ] && wp core download

[ ! -f "wp-config.php" ] && Create_config

php-fpm81 -FR
