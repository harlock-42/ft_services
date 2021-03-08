FROM alpine:3.13.2

RUN apk update \
&& apk add openssl \
&& apk add vim \
&& apk add nginx

# This repo is necessary to start nginx, however it doesn't exixt on alpine image
RUN mkdir -p /run/nginx

WORKDIR /etc/nginx

# Generate a SSL key
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/nginx/cert.key \
-out	/etc/nginx/cert.crt \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

WORKDIR ../..

COPY index.html /data/www/index.html

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT nginx -g "daemon off;"
