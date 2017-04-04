#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'
sudo apt-get update
sudo apt-get install -y vim curl python-software-properties
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get update
sudo apt-get install -y mysql-server-5.6

sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
sudo /etc/init.d/mysql restart
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
