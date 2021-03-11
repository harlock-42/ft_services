FROM alpine:3.13

RUN apk update && \
apk add vim

RUN apk add influxdb

RUN apk add openrc

RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel

RUN openrc >/dev/null 2>&1

COPY influxdb.conf /etc/influxdb.conf

COPY init.sh /tmp/init.sh

ENTRYPOINT /tmp/init.sh
