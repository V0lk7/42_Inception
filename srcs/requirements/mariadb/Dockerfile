FROM alpine:3.17

COPY	--chmod=655 tools/configure.sh /

RUN	apk update && apk upgrade; \
	apk add mariadb mariadb-client mariadb-server-utils

CMD ["sh","./configure.sh"]
