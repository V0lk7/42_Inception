FROM alpine:3.17

COPY --chmod=777 tools/configure.sh /

RUN ./configure.sh

CMD ["nginx", "-g", "daemon off;"]
