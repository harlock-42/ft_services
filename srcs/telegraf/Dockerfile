FROM alpine:3.13

RUN apk update

RUN apk add telegraf

RUN mkdir -p /var/log/telegraf

RUN touch /var/log/telegraf/telegraf.log

COPY telegraf.conf /etc/telegraf/telegraf.conf

RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

COPY init.sh /tmp/init.sh

ENTRYPOINT /tmp/init.sh
