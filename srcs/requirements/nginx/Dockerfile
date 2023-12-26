FROM alpine:3.17

COPY --chmod=655 tools/nginx-configure.sh /
COPY --chmod=777 conf/nginx.conf /

RUN	apk update && apk upgrade; \
	apk add nginx openssl; \
	mv nginx.conf /etc/nginx ; \
	mkdir -p /etc/nginx/ssl

EXPOSE 443

CMD ["sh","nginx-configure.sh"]
