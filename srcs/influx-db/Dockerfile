FROM alpine:3.13

RUN apk update && \
apk add vim

RUN apk add influxdb

COPY influxdb.conf /etc/influxdb.conf
