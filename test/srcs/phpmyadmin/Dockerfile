FROM alpine:3.13

RUN apk update

RUN apk add vim

# Installing openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN apk add openrc
RUN openrc >/dev/null 2>&1

# Installing and setup nginx
RUN apk add nginx
RUN mkdir -p /run/nginx
COPY default.conf /etc/nginx/http.d/default.conf

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

# PHP installation and setup
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mbstring php7-gettext php7-session
COPY phpmyadmin /var/www/phpnyadmin
COPY config.inc.php /var/www/phpmyadmin/config.inc.php


COPY init.sh /tmp/init.sh


ENTRYPOINT /tmp/init.sh
