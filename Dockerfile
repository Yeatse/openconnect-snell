FROM ubuntu:latest

LABEL maintainer="Yang Chao <iyeatse@gmail.com>"

RUN apt update
RUN apt -y install wget unzip openconnect

RUN arch=$(arch | sed s/arm64/aarch64/ | sed s/x86_64/amd64/) \
  && wget -O snell-server.zip https://dl.nssurge.com/snell/snell-server-v4.0.0-linux-${arch}.zip \
  && unzip snell-server.zip \
  && mv snell-server /usr/local/bin/

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

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
