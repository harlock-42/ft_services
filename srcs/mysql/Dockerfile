FROM alpine:3.13


# instaling packages
RUN apk update \
&& apk add --no-cache vim \
&& apk add --no-cache openrc

RUN apk add --no-cache mariadb mariadb-client

# necessary for `/etc/init.d/mariadb setup`
RUN mkdir -p /run/openrc \
&& touch /run/openrc/softlevel

COPY mariadb-server.cnf /etc/my.cnf.d/

RUN mkdir -p /run/mysqld \
&& chown mysql /var/lib/mysql

# Place the init.sh in the /tmp/ path of the container. I use a .sh file because the container has to be run to start mariadb.
COPY init.sh /tmp/init.sh

# Give permission to init.sh file to be executable
RUN chmod 711 /tmp/init.sh

# start mariadb to create /etc/init.d/mariadb and other executable in this path
ENTRYPOINT ./tmp/init.sh


