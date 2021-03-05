FROM alpine:3.13.2

RUN apk update

RUN apk add mysql mysql-client

RUN apk add openrc

RUN mkdir -p /run/openrc

RUN touch /run/openrc/softlevel && openrc >/dev/null 2>&1

COPY conf.sql /tmp/conf.sql

COPY init.sh /tmp/init.sh

RUN chmod 777 /tmp/init.sh

ENTRYPOINT /tmp/init.sh
