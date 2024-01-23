# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #Base de donnée - MariaDB (On lance d'abord la BDD pour pouvoir faire la migration dans le script import_script.sh)
  config.vm.define "bdd" do |database|
    database.vm.hostname = "bdd"
    database.vm.box = "chavinje/fr-bull-64"
    database.vm.network :private_network, ip: "192.168.56.81"

    database.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "bdd"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 2*1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end
    database.vm.provision "shell", path: "scripts/install_sys.sh"
    database.vm.provision "shell", path: "scripts/install_web.sh"
    database.vm.provision "shell", path: "scripts/install_bdd.sh"


  end

  # Serveur virtuel de démonstration
  config.vm.define "srv-web" do |machine|
    machine.vm.hostname = "srv-web"
    machine.vm.box = "chavinje/fr-bull-64"
    machine.vm.network :private_network, ip: "192.168.56.80"
    # Un repertoire partagé est un plus mais demande beaucoup plus
    # de travail - a voir à la fin
    #machine.vm.synced_folder "./data", "/vagrant_data", SharedFoldersEnableSymlinksCreate: false
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "srv-web"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 2*1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end
    config.vm.provision "shell", inline: <<-SHELL
        sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config    
        sleep 3
        service ssh restart
      SHELL
      machine.vm.provision "shell", path: "scripts/install_sys.sh"
      machine.vm.provision "shell", path: "scripts/install_web.sh"
      machine.vm.provision "shell", path: "scripts/install_myadmin.sh"
      machine.vm.provision "shell", path: "scripts/composer.sh"
      machine.vm.provision "shell", path: "scripts/import_script.sh"
  end



#Reverse Proxy
  config.vm.define "reverse-proxy" do |proxy|
    proxy.vm.hostname = "reverse-proxy"
    proxy.vm.box = "chavinje/fr-bull-64"
    proxy.vm.network :private_network, ip: "192.168.56.82"
    proxy.vm.network "public_network", use_dhcp_assigned_default_route: true
  	

    proxy.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--name", "reverse-proxy"]
      v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
      v.customize ["modifyvm", :id, "--cpus", "2"]
      v.customize ["modifyvm", :id, "--memory", 2*1024]
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    end
    proxy.vm.provision "shell", path: "scripts/install_sys.sh"
    proxy.vm.provision "shell", path: "scripts/install_web.sh"
    proxy.vm.provision "shell", path: "scripts/ReverseProxy.sh"
   end

#Backup
config.vm.define "backup" do |back|
  back.vm.hostname = "backup"
  back.vm.box = "chavinje/fr-bull-64"
  back.vm.network :private_network, ip: "192.168.56.83"

  back.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--name", "backup"]
    v.customize ["modifyvm", :id, "--groups", "/S7-projet"]
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--memory", 2*1024]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
  end
  back.vm.provision "shell", path: "scripts/install_sys.sh"
  back.vm.provision "shell", path: "scripts/backup_script.sh"
  
end

end
