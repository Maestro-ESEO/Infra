echo "Début import scripts"

#Les devs ont utilisés Laravel, un framework pour la partie Web qui nécessite une configuration
echo '
    <VirtualHost *:80>
    ServerName Maestro
    DocumentRoot /var/www/html/Web-App/public
 
    <Directory /var/www/html/Web-App>
    Options Indexes MultiViews FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>
 
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' | sudo tee /etc/apache2/sites-available/webapp.conf > /dev/null
 
sudo a2dissite 000-default.conf
sudo a2enmod rewrite
sudo a2ensite webapp.conf
 
sudo systemctl restart apache2

#Clonage de la partie dev depuis github 
cd /var/www/html
sudo git clone https://github.com/Maestro-ESEO/Web-App.git

#Le fichier .env est un fichier de Laravel, on substitut les éléments pour l'adapter à notre projet
#Le fichier .env définis la connexion à la bdd
cd Web-App
sudo cp .env.example .env
sudo sed -i 's/APP_NAME=Laravel/APP_NAME=Maestro/g' /var/www/html/Web-App/.env
sudo sed -i 's/DB_HOST=127.0.0.1/DB_HOST=192.168.56.81/g' /var/www/html/Web-App/.env
sudo sed -i 's/DB_DATABASE=laravel/DB_DATABASE=BddMaestro/g' /var/www/html/Web-App/.env
sudo sed -i 's/root/admin/g' /var/www/html/Web-App/.env
sudo sed -i 's/DB_PASSWORD=/DB_PASSWORD=network/g' /var/www/html/Web-App/.env
sudo sed -i 's/APP_ENV=local /APP_ENV=production/g' /var/www/html/Web-App/.env
sudo sed -i 's/APP_DEBUG=true /APP_DEBUG=false/g' /var/www/html/Web-App/.env

#On va chercher le fichier composer.json et on installe les dépendances
sudo composer install
cd /var/www/html/Web-App
#On autorise l'accès et l'écriture sur le fichier storage de manière récursive
sudo chmod -R 775 storage
sudo chmod -R ugo+rw storage

#On génère une nouvelle clé pour le projet (recquis par laravel) puis on génère les tables et "--seed" permet de les remplir automatiquement

sudo php artisan key:generate
sudo php artisan migrate:fresh --seed

echo "Scripts importé, serveur Web prêt"
