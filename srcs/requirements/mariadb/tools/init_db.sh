#!/bin/bash
touch self_config.sql
mysql_install_db --user=mysql --datadir="/var/lib/mysql" > /dev/null

if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ]; then
echo "db not exists"
echo "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
	USE ${MARIADB_DATABASE};
	GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}' WITH GRANT OPTION;
	GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db LIKE 'test\\_%';
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
	FLUSH PRIVILEGES;
	UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root';
	FLUSH PRIVILEGES;" >> self_config.sql;

service mariadb start ;
mysql < self_config.sql;
rm -f self_config.sql;
mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown || echo "Error: mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown";
fi

/usr/bin/mysqld_safe --user=mysql --datadir=/var/lib/mysql