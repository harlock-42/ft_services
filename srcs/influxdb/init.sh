rc-service influxdb start

echo "CREATE DATABASE metrics" | influx

echo "CREATE USER harlock WITH PASSWORD 'user42' WITH ALL PRIVILEGES" | influx

telegraf

sleep infinity
