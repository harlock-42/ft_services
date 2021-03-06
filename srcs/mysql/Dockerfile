FROM alpine:3.13


# instaling packages
RUN apk update \
&& apk add --no-cache vim \
&& apk add --no-cache openrc

RUN apk add --no-cache mariadb mariadb-client

# onpenrc installation and fixing
RUN apk add --no-cache openrc

RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel

RUN openrc >/dev/null 2>&1

COPY init.sh /tmp/init.sh

# Give permission to init.sh file to be executable
RUN chmod 711 /tmp/init.sh

# start mariadb to create /etc/init.d/mariadb and other executable in this path
ENTRYPOINT ./tmp/init.sh
