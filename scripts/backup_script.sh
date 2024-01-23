#!/bin/bash
 
sudo apt update
apt-get install -o Dpkg::Progress-Fancy="0" -q -y \
 mariadb-server \
 mariadb-client \

#On entre en variable les paramètres de connexion à la BDD
db_host="192.168.56.81"
db_user="admin"
db_password="network"
db_name="BddMaestro"

#On crée le répertoire de sauvegarde
backup_directory="/backup"
mkdir $backup_directory

#On utilise une variable de temps pour dissocier les sauvegardes
timestamp=$(date +"%Y%m%d_%H%M%S")
 
#Création du fichier backup
backup_file="$backup_directory/$db_name-$timestamp.sql"
 
#On transfère les données de la BDD vers le backup
mysqldump -h "$db_host" -u "$db_user" -p"$db_password" "$db_name" > "$backup_file"
echo "Le backup a été correctement effectué"
 
#On implémente une récurrence en réexécutant le script tous les jours  
cp /vagrant/scripts/backup_script.sh $backup_directory/backup_script.sh
touch $backup_directory/crontab
echo "* * * * * $backup_directory/backup_script.sh" | crontab -