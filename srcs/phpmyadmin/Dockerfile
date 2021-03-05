FROM alpine:3.13.2

RUN apk update \
&& apk add vim \
&& apk add openssl \
&& apk add nginx

# This repository is necessary to start nginx, however it doesn't exixt on alpine image
RUN mkdir -p /run/nginx

RUN mkdir -p /data/www/phpmyadmin

# Generate a SSL key
RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/nginx/cert.key \
-out	/etc/nginx/cert.crt \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

COPY index.html /data/www/phpmyadmin/index.html

COPY nginx.conf /etc/nginx/nginx.conf

COPY phpmyadmin /tmp/phpmyadmin

# Start nginx in an infinity loop
#ENTRYPOINT nginx -g "daemon off;"
#ENTRYPOINT ["./path/nginx"] ["-g"] ["daemon off;"]
