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

COPY grafana.ini /etc/grafana.ini

ENTRYPOINT /usr/sbin/grafana-server --homepath=/usr/share/grafana/
