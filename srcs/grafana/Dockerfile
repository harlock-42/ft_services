FROM alpine:3.13

RUN apk update

RUN apk add grafana && \
apk add openssl && \
apk add vim

# Telegraf configuration
RUN apk add telegraf
RUN mkdir -p /var/log/telegraf
RUN touch /var/log/telegraf/telegraf.log
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

#COPY grafana.db /usr/share/grafana/data/grafana.db
RUN rm -rf /usr/share/grafna
COPY grafana.tar.gz /usr/share/grafana.tar.gz
WORKDIR /usr/share
RUN tar xzvf grafana.tar.gz
RUN rm -rf grafana.tar.gz
WORKDIR ../..
RUN rm /usr/share/grafana/conf/sample.ini
COPY grafana.ini /usr/share/grafana/conf/grafana.ini

COPY init.sh /tmp/init.sh

RUN chmod 755 /tmp/init.sh

ENTRYPOINT /tmp/init.sh

EXPOSE 3000
