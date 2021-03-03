# initialize mysql database
/etc/init.d/mariadb setup

# start mariadb
/etc/init.d/mariadb start

# generate an infinity loop to keep the container running
sleep infinity
