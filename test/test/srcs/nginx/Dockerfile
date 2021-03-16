FROM alpine:3.13

RUN apk update

# Installing openrc
RUN apk add openrc
RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel
RUN openrc >/dev/null 2>&1

# Installing and setup nginx
RUN apk add nginx
RUN mkdir -p /run/nginx
#COPY default.conf /etc/nginx/http.d/default.conf
COPY index.html /var/www/index.html
