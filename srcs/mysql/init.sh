
/etc/init.d/mariadb setup

/etc/init.d/mariadb start >> /dev/null

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

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/my.cnf

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

sed -i "s|.*skip-networking.*|skip-networking|g" /etc/mysql/my.cnf

# Modifying /etc/my.cnf.d/mariadb-server.cnf

sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

# setup database

echo "CREATE USER 'harlock'@'localhost' IDENTIFIED BY 'user42' ;" | mysql -u root

echo "CREATE DATABASE data ; " | mysql -u root

echo "GRANT ALL PRIVILEGES ON *.* TO 'harlock'@'localhost' WITH GRANT OPTION ;" | mysql -u root

echo "FLUSH PRIVILEGES ;" | mysql -u root

telegraf

# generate an infinity loop to keep the container running
sleep infinity
