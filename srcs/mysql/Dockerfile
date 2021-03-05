FROM alpine:3.13


# instaling packages
RUN apk update


# necessary for `/etc/init.d/mariadb setup`
RUN apk add --no-cache openrc \
&& mkdir -p /run/openrc \
&& touch /run/openrc/softlevel \
openrc >/dev/null 2>&1

# Mysql setup
RUN apk add --no-cache mysql mysql-client


# Place the init.sh in the /tmp/ path of the container. I use a .sh file because the container has to be run to start mariadb.
COPY init.sh /tmp/init.sh

#COPY ./mariadb-server.cnf /etc/my.cnf.d/.

#RUN mkdir -p /run/mysqld

#RUN chown mysql /var/lib/mysql

# Give permission to init.sh file to be executable
RUN chmod 711 /tmp/init.sh

# start mariadb to create /etc/init.d/mariadb and other executable in this path
ENTRYPOINT ./tmp/init.sh


