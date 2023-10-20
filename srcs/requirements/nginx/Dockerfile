FROM alpine:3.17

RUN	apk update && apk upgrade; \
	apk add nginx openssl; \
	mkdir -p /wordpress

COPY --chmod=655 tools/nginx-configure.sh /
COPY --chmod=344 conf/nginx.conf /

EXPOSE 443

CMD ["sh","nginx-configure.sh"]
