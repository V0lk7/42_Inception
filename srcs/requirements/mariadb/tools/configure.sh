#!bin/sh

Create_mysqldir(){
	mkdir -p /run/mysqld
	chown mysql:mysql /run/mysqld
	chmod 777 /run/mysqld
}

Create_Database(){
	chown mysql:mysql /var/lib/mysql
	mysql_install_db --skip-test-db --user=mysql --ldata=/var/lib/mysql > /dev/null

	mysqld --user=mysql --bootstrap << EOF
USE mysql ;
FLUSH PRIVILEGES ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER IF NOT EXISTS '$WPADMIN_USERNAME'@'%' IDENTIFIED BY '$WPADMIN_PASSWORD';
SET PASSWORD FOR '$WPADMIN_USERNAME'@'%' = PASSWORD('$WPADMIN_PASSWORD');
GRANT ALL ON $DATABASE_NAME.* TO '$WPADMIN_USERNAME'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES ;
EOF
}

[ ! -d "/run/mysqld" ] && Create_mysqldir

[ ! -d "/var/lib/mysql/mysql" ] && Create_Database

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|skip-networking=OFF\nskip-grant-tables=0|g" /etc/my.cnf.d/mariadb-server.cnf


#Launch mysqld server
exec /usr/bin/mysqld --user=mysql --port=3306 --console
