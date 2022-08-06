CREATE DATABASE suitecrm;
CREATE USER 'suiteuser'@'localhost' IDENTIFIED BY 'suitecrm';
GRANT ALL PRIVILEGES ON suitecrm.* TO 'suiteuser'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'fcarmona';
FLUSH PRIVILEGES;
quit;
