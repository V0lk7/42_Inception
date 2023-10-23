FROM alpine:3.17

RUN	apk update && apk upgrade; \
	apk add mariadb mariadb-client; \
	mkdir -p /run/mysqld; \
	chown mysql:mysql /run/mysqld; \
	chmod 777 /run/mysqld; \
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf; \
	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf; \
	mysql_install_db --datadir=/var/lib/mysql --user=mysql

EXPOSE 3306

#CMD ["mysqld_safe","--port=3306"]
