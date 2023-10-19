FROM alpine:3.17

RUN	apk update && apk upgrade; \
	apk add mariadb mariadb-client mariadb-server-utils; \
	mkdir -p /run/mysqld; \
	chown mysql:mysql /run/mysqld; \
	mysql_install_db --datadir=/var/lib/mysql --user=mysql

EXPOSE 3306

CMD ["mysqld_safe","--port=3306"]
