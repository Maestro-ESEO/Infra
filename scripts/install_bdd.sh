#!/bin/bash

## install Mariadb server (ex Mysql))

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_bdd.log"
DEBIAN_FRONTEND="noninteractive"

#Utilisateur a créer (si un vide alors pas de création)
DBNAME="BddMaestro"
DBUSER="admin"
DBPASSWD="network"

#Fichier sql à injecter (présent dans un sous répertoire)
echo "hello"

DBFILE="/vagrant/files/creation_bdd.sql"

echo "START - install MariaDB - "$IP

echo "=> [1]: Install required packages ..."
DEBIAN_FRONTEND=noninteractive
apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
	mariadb-server \
	mariadb-client \
   >> $LOG_FILE 2>&1

echo "=> [2]: Configuration du service"
if [ -n "$DBNAME" ] && [ -n "$DBUSER" ] && [ -n "$DBPASSWD" ] ;then
  mysql -e "CREATE DATABASE $DBNAME" \
  >> $LOG_FILE 2>&1
  mysql -e "grant all privileges on $DBNAME.* to '$DBUSER'@'%' identified by '$DBPASSWD'" \
  >> $LOG_FILE 2>&1
fi

echo "=> [3]: Configuration de BDD"
if [ -f "$DBFILE" ] ;then
  mysql -u $DBUSER -p$DBPASSWD $DBNAME < $DBFILE \
  >> $LOG_FILE 2>&1
fi

#On modifie la BindAddress pour rendre l'accès possible depuis des srv externes
sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

#On installe un firewall  poursécurisé la BDD et simplifié l'ouverture des ports
sudo apt-get -y install ufw
echo "y" | sudo ufw enable
sudo ufw allow 3306
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 22
sudo systemctl restart apache2
sudo systemctl restart mariadb


echo "END - install MariaDB"

