CREATE DATABASE wordpress;

CREATE USER 'harlock' IDENTIFIED BY 'harlock';
GRANT USAGE ON wordpress.* TO 'harlock'@'localhost' IDENTIFIED BY 'harlock';
GRANT ALL PRIVILEGES ON wordpress.* TO 'harlock'@'localhost';
FLUSH PRIVILEGES;
