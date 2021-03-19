FROM alpine:3.13

RUN apk update

# nginx config

RUN apk add vim && \
apk add wget

RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mbstring php7-gettext php7-session

# openrc intallation
RUN apk add openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

# Installing and setup nginx
RUN apk add nginx
RUN mkdir -p /run/nginx
COPY default.conf /etc/nginx/http.d/default.conf
#COPY phpmyadmin /var/www/phpmyadmin

# PhpMyAdmin
WORKDIR /var/www
RUN wget -q http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
    tar -zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && rm phpMyAdmin-5.0.2-all-languages.tar.gz  && \
    mv phpMyAdmin-5.0.2-all-languages phpmyadmin && \
    chmod -R 777 /var/www/phpmyadmin/
COPY /config.inc.php /var/www/phpmyadmin/

#COPY config.inc.php /var/www/phpmyadmin/config.inc.php

# SSL installation
RUN apk add openssl
RUN mkdir -p /etc/ssl/private && \
mkdir -p /etc/ssl/certs
RUN chmod 700 /etc/ssl/private && \
chmod 700 /etc/ssl/certs
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out	/etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

# Telegraf configuration
#RUN apk add telegraf
#RUN mkdir -p /var/log/telegraf
#RUN touch /var/log/telegraf/telegraf.log
#COPY telegraf.conf /etc/telegraf/telegraf.conf
#RUN export TELEGRAF_CONFIG_PATH="/etc/telegraf/telegraf.conf"

COPY init.sh tmp/init.sh

ENTRYPOINT sh ./tmp/init.sh

EXPOSE 5000
