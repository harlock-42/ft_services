
mysql_install_db --user=root --datadir=/var/lib/mysql

# start the mysql deamon
mysqld --console

# start mysql client
/etc/init.d/mariadb start

#
mysql_secure_installation <<EOF

n
n
y
y
y
y
EOF

# generate an infinity loop to keep the container running
sleep infinity
