#!bin/sh

if [ -d "/run/mysqld" ]; then
	echo "/run/mysqld already exist. Skipping creation."
else
	mkdir -p /run/mysqld
	chown mysql:mysql /run/mysqld
	chmod 777 /run/mysqld
fi

if [ -d "/var/lib/mysql/mysql" ]; then
	echo "/var/lib/mysqld already exist. Skipping creation."
	chown -R mysql:mysql /var/lib/mysql
else
	echo "/var/lib/mysqld not found. Creating initial database."
	chown mysql:mysql /var/lib/mysql
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
	mysql_install_db --skip-test-db --verbose --user=mysql --ldata=/var/lib/mysql > /dev/null

	mysqld --user=mysql --bootstrap << EOF
USE mysql ;
FLUSH PRIVILEGES ;
CREATE USER IF NOT EXISTS root@localhost IDENTIFIED BY '$ROOT_PASSWORD';
SET PASSWORD FOR root@localhost = PASSWORD('$ROOT_PASSWORD');
GRANT ALL ON *.* TO root@localhost WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER IF NOT EXISTS $WPADMIN_USERNAME@localhost IDENTIFIED BY '$WPADMIN_PASSWORD';
SET PASSWORD FOR $WPADMIN_USERNAME@localhost = PASSWORD('$WPADMIN_PASSWORD');
GRANT ALL ON $DATABASE_NAME.* TO $WPADMIN_USERNAME@localhost WITH GRANT OPTION;
CREATE USER IF NOT EXISTS $WP_USERNAME@localhost IDENTIFIED BY '$WP_PASSWORD';
SET PASSWORD FOR $WP_USERNAME@localhost = PASSWORD('$WP_PASSWORD');
GRANT USAGE ON $DATABASE_NAME.* TO $WP_USERNAME@localhost WITH GRANT OPTION;
FLUSH PRIVILEGES ;
EOF

fi

#Launch mysqld server
mysqld_safe --user=mysql --port=3306