**Bienvenue sur MAESTRO**

Introduction:
Maestro est une plateforme collaborative de gestion de projet. Elle comporte une application Web et une application bureau.


Infrastructure:
La plateforme est hébergé sur 4 serveurs sous forme de machine virtuelle. 
- Un serveur Web: qui a pour objectif d'héberger le site web. On y retrouve les outils suivants: 
	- PHP
	- Composer
	- MyAdmin
	- Git
	- Apache2
IP: 192.168.56.80 (réseau privé)

- Un serveur Base de donnée qui a pour objectif d'héberger la database utilisé pour l'application web et bureau. On y retrouve les outils suivants:
	- MySql
	- Apache2
	- UFW
IP: 192.168.56.81 (réseau privé)

- Un serveur Backup qui a pour objectif de réaliser une sauvegarde tous les jours à 1h du matin de la base donnée pour ne pas perdre d'informations. On y retrouve les outils suivants:
	- Apache2
IP: 192.168.56.83 (réseau privé)
	
-Un serveur reverse proxy qui a pour objectif de protéger le réseau de serveur en filtrant les requêtes envoyé. On y retrouve les outils suivants:
	- Apache2 reverse-proxy
	- Apache2 proxy
IP: 192.168.56.82 (réseau privé)
IP: 192.168.4.193 (bridge)

Les serveurs ont été automatisé avec Vagrant, pour lancer les serveurs il faut installer la Box chavinje/fr-Bull-64 avec la commande: vagrant box add chavinje/fr-bull-64
Ensuite on ajoute la commande: vagrant up

Les applications obligatoires
Oracle Virtualbox (version 6.1) (https://www.virtualbox.org/wiki/Downloads)
Oracle VM VirtualBox Extension Pack (adapté à la version de virtualbox installée précédement)
HashiCorp Vagrant (https://www.vagrantup.com/)

Télécharger la box modèle vagrant box add chavinje/fr-bull-64

Activer une VM uniquement (srv-web par exemple) vagrant up srv-web

Se connecter à une VM (reverse-proxy par exemple) vagrant ssh reverse-proxy

Arrêter une VM (victime par exemple) vagrant halt victime

Détruire toutes les VMs (sans demande de confirmation) vagrant destroy -f

./Vagrantfile : qui contient l'ensemble des déclarations pour la construction du Labs
scripts/install_sys.sh : mise en place des configurations de base sur toutes les VMs
scripts/install_bdd.sh : Mise en place de la base de données mysql
scripts/install_moodle.sh : Mise en place de l'application Moodle
scripts/install_myadmin.sh : Mise en place de l'application PhpMyAdmin
scripts/install_web.sh : Mise en place du serveur Apache2
scripts/import_script.sh : Import des scripts devs
scripts/reverseProxy.sh : Mise en place du reverse proxy 
scripts/composer.sh : Installation et configuration du framework Composer
scripts/Backup_script.sh : Mise en place d'un backup répété une fois par jour

Pour se connecter à MyAdmin:
User: admin
Password: network
