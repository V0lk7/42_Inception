FROM alpine:3.17

RUN apk update && apk upgrade
RUN apk add nginx
RUN apk add openssl

COPY --chmod=655 tools/configure.sh /
COPY --chmod=344 conf/nginx.conf /

EXPOSE 443

CMD ["sh","configure.sh"]
