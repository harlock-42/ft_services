FROM alpine:3.13.2

RUN apk update
RUN apk add mysql mysql-client
RUN apk add openrc
RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel && openrc >/dev/null 2>&1

#RUN apk add telegraf
#RUN mkdir -p etc/telegraf/ && mkdir -p /var/log/telegraf-log
#RUN touch /var/log/telegraf-log/telegraf.log
#COPY ./srcs/telegraf.conf /etc/telegraf/

COPY ./conf.sql /tmp/
#COPY /wordpress.sql /tmp/
COPY ./init.sh /tmp/init.sh
RUN chmod 755 ./tmp/init.sh

EXPOSE 	3306
ENTRYPOINT sh ./tmp/init.sh
