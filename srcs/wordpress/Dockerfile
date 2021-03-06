FROM alpine:3.13

RUN apk add wget \
&& apk add vim \
&& apk add nginx

RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-mbstring php7-gettext php7-session

RUN mkdir -p /run/nginx

# onpenrc installation and fixing
RUN apk add --no-cache openrc

RUN mkdir -p /run/openrc && \
touch /run/openrc/softlevel

RUN openrc >/dev/null 2>&1

COPY nginx.conf /etc/nginx/nginx.conf

COPY wordpress /var/www/localhost/wordpress

COPY init.sh /tmp/init.sh

RUN chmod 711 /tmp/init.sh

ENTRYPOINT /tmp/init.sh