FROM alpine:3.13

RUN apk update

# openrc intallation
RUN apk add openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

# Generate a SSL key
RUN apk add openssl
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-out /etc/ssl/certs/cert.pem \
-keyout /etc/ssl/private/key.pem \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

# Telegraf configuration
RUN apk add telegraf
RUN mkdir -p /var/log/telegraf
RUN touch /var/log/telegraf/telegraf.log
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

# vsftpd installation and config
RUN apk add vsftpd
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
RUN adduser --disabled-password --home etc/vsftpd/home harlock
RUN echo "harlock:user42" | chpasswd
RUN echo 'Yo Harlock !' >> etc/vsftpd/home/testfile.txt
RUN chown harlock /
RUN chmod 766 /etc/vsftpd/home/testfile.txt

COPY ./init.sh /tmp/init.sh
RUN chmod 755 /tmp/init.sh

ENTRYPOINT /tmp/init.sh
