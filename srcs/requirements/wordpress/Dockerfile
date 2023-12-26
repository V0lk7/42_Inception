FROM 	alpine:3.17

COPY	--chmod=777 tools/configure.sh /
COPY	--chmod=777 conf/www.conf /

RUN	apk update && apk upgrade; \
	apk add php php-phar php-curl php-mysqli php-fpm php-mbstring; \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp; \
	adduser -S "nginx" && addgroup -S "nginx"; \
	mkdir -p /var/www ; \
	chown -R nginx:nginx /var/www  && chmod -R 777 /var/www ; \
	mv /www.conf /etc/php81/php-fpm.d/ ;

WORKDIR /var/www/

CMD	["sh", "/configure.sh"]
