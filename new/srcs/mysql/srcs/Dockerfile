FROM alpine:3.13

# instaling packages
RUN apk update

RUN apk add mariadb mariadb-client

# onpenrc installation and fixing
RUN apk add openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

# Telegraf configuration
#RUN apk add telegraf
#RUN mkdir -p /var/log/telegraf
#RUN touch /var/log/telegraf/telegraf.log
#COPY telegraf.conf /etc/telegraf/telegraf.conf
#RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

COPY init.sh /tmp/init.sh
COPY conf.sql /tmp/conf.sql

# Give permission to init.sh file to be executable
RUN chmod 711 /tmp/init.sh

# start mariadb to create /etc/init.d/mariadb and other executable in this path
ENTRYPOINT ./tmp/init.sh

EXPOSE 3306
