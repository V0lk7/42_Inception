FROM alpine:3.17

COPY --chmod=655 tools/configure.sh /
COPY --chmod=344 conf/nginx.conf /

EXPOSE 443

CMD ["sh","configure.sh"]
