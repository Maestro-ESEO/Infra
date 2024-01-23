  # Mise à jour des paquets
    sudo apt-get update

    # Activation des modules du proxy
    sudo a2enmod proxy
    sudo a2enmod proxy_http

    # Configuration du reverse proxy
    echo '
    <VirtualHost *:80>
        
        ServerName localhost
                ProxyRequests Off
        ProxyPreserveHost On

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>

        ProxyPass / http://192.168.56.80/
        ProxyPassReverse / http://192.168.56.80/

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>' | sudo tee /etc/apache2/sites-available/reverse-proxy.conf > /dev/null

# Activation du site et redémarrage d'Apache
sudo a2dissite 000-default.conf
sudo a2ensite reverse-proxy
sudo systemctl restart apache2

echo "installation du reverse-proxy terminée" 