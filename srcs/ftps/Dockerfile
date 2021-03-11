FROM alpine:3.13

RUN apk update

RUN apk add vsftpd

# Generate a SSL key
RUN apk add openssl

RUN openssl req -x509 \
-nodes \
-days 365 \
-newkey rsa:2048 \
-keyout /etc/ssl/certs/cert.pem \
-out	/etc/ssl/private/key.pem \
-subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=harlock/CN=localhost"

# openrc installing
RUN apk add openrc

RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel

RUN openrc >/dev/null 2>&1

COPY vsftpd.conf /etc/vsftpd.conf

COPY init.sh /tmp/init.sh

ENTRYPOINT /tmp/init.sh

EXPOSE 21


