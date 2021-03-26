
telegraf & /etc/init.d/mariadb setup

/etc/init.d/mariadb start 2 /dev/null

# 
mysql_secure_installation <<EOF

n
n
y
y
y
y
EOF

# Modifying /etc/mysql/my.cnf

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
rc-service mariadb restart

# setup database
mysql < /tmp/conf.sql
mysql wordpress < /tmp/wordpress.sql

# generate an infinity loop to keep the container running
sleep infinity
