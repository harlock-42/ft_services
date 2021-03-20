CREATE DATABASE mysql;
CREATE USER 'harlock'@'%' IDENTIFIED BY 'harlock';
GRANT ALL PRIVILEGES ON wordpress.* TO 'harlock'@'%';
CREATE USER 'harlock-metrics'@'%' IDENTIFIED BY 'harlock';
GRANT ALL PRIVILEGES ON wordpress.* TO 'harlock-metrics'@'%';
FLUSH PRIVILEGES;
