FROM alpine:3.13

RUN apk update

RUN apk add grafana && \
apk add openssl && \
apk add vim

# Generate a SSL key
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/certs/cert.pem \
-out	/etc/ssl/private/key.pem \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

# Telegraf configuration
RUN apk add telegraf
RUN mkdir -p /var/log/telegraf
RUN touch /var/log/telegraf/telegraf.log
COPY telegraf.conf /etc/telegraf/telegraf.conf
RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

COPY grafana.ini /etc/grafana.ini

COPY init.sh /tmp/init.sh

RUN chmod 755 /tmp/init.sh

ENTRYPOINT /tmp/init.sh

EXPOSE 3000
