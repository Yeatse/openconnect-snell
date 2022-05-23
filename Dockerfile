FROM alpine:edge

LABEL maintainer="DianQK <dianqk@icloud.com>"

RUN apk update \
  && apk add --no-cache \
    unzip \
    libstdc++ \
  && wget -O snell-server.zip https://github.com/surge-networks/snell/releases/download/v3.0.1/snell-server-v3.0.1-linux-aarch64.zip \
  && unzip snell-server.zip \
  && mv snell-server /usr/local/bin/

COPY glibc-bin-2.35.tar.gz .

RUN tar -zxf glibc-bin-2.35.tar.gz \
  && ln -sf /usr/glibc-compat/lib/ld-linux-aarch64.so.1 /lib/ld-linux-aarch64.so.1

ENV LD_LIBRARY_PATH /usr/glibc-compat/lib:/usr/local/lib:/usr/lib:/lib

ENV SERVER_HOST 0.0.0.0
ENV SERVER_PORT 8388
ENV PSK=
ENV OBFS http

EXPOSE ${SERVER_PORT}/tcp
EXPOSE ${SERVER_PORT}/udp

ENV OC_USER=
ENV OC_PASSWD= 
ENV OC_AUTH_GROUP=
ENV OC_AUTH_CODE=
ENV OC_HOST=
ENV OC_ADDITIONAL_OPTIONS=

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ openconnect

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
