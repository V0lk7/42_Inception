FROM alpine:3.17

COPY	--chmod=655 tools/configure.sh /

RUN	apk update && apk upgrade; \
	apk add php php-phar php-curl php-mysqli php-fpm php-mbstring; \
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

CMD	["sh", "./configure.sh"]
