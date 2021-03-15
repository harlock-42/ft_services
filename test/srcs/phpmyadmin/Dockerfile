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
COPY index.html /var/www/index.html

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

COPY init.sh /tmp/init.sh


ENTRYPOINT /tmp/init.sh
