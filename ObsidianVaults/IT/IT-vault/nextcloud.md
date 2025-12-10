
1. Setup [mariadb](https://mariadb.org/)
   [arch install](https://wiki.archlinux.org/title/MariaDB)
	1. `yay -S mariadb`
	2. `sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`
	3. `sudo systemctl start mariadb`
2. Create nextcloud database