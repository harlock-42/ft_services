FROM alpine:3.13

RUN apk update

# nginx config

RUN apk add vim && \
apk add wget

# install php packages
RUN apk add php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-sockets php7-common php7-opcache php7-zlib php7-curl php7-gd php7-cgi

# openrc intallation
RUN apk add openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

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

# Installing and setup nginx
RUN apk add nginx
RUN mkdir -p /run/nginx
COPY default.conf /etc/nginx/http.d/default.conf

# Installing and setup wordpress
WORKDIR /var/www/
RUN wget -q http://wordpress.org/latest.tar.gz

ENTRYPOINT nginx -g "daemon off;"
