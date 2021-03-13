FROM alpine:3.13

RUN apk update && \
apk add vim

RUN apk add influxdb

RUN apk add openrc

RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel

RUN openrc >/dev/null 2>&1

# Telegraf configuration
RUN apk add telegraf
RUN mkdir -p /var/log/telegraf
RUN touch /var/log/telegraf/telegraf.log
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

COPY influxdb.conf /etc/influxdb.conf

COPY init.sh /tmp/init.sh

ENTRYPOINT /tmp/init.sh
