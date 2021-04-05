CREATE DATABASE wordpress;
CREATE USER 'harlock'@'%' IDENTIFIED BY 'user42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'harlock'@'%';
CREATE USER 'harlock-metrics'@'%' IDENTIFIED BY 'user42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'harlock'@'%';
FLUSH PRIVILEGES;
