#! /bin/bash
usuario=$(whoami)
opcion=1
clear
sudo su

echo "---------- MENU INSTALACION DE SUITECRM ----------"
echo "=================================================="
echo ""
echo "Siga los siguientes pasos en el orden establecido:"
echo "--------------------------------------------------"
echo "1. Instalacion de GIT"
echo "2. Instalacion de php y modulos adicionales"
echo "3. Instalacion de Apache"
echo "4. Instalacion de MySQL"
echo "5. Configuraciones adicionales"
echo "0. Salir"
echo ""
echo "SELECCIONE OPCION:"
read opcion

while [ $opcion -ne 0 ]; do

      case $opcion in
        1)
          clear
          echo "Iniciando instalacion de GIT";
          apt-get update
          apt-get install git -y
          clear
          sudo /home/ubuntu/menu.sh
          ;;
        2)
          clear
          echo "Iniciando descarga de SuiteCRM e Instalacion de Composer:"
          mkdir tmp
          cd /tmp/
          sudo git clone https://github.com/salesagility/SuiteCRM.git suitecrm
          clear
          ls
          sleep 6
          mv suitecrm /var/www/
          cd /var/www/
          clear
          ls
          sleep 6
          chown -R www-data.www-data suitecrm
          chmod -R 775 suitecrm
          sudo apt remove php8*
          sudo apt-get purge php*
          sudo apt-get autoremove
          sudo apt-get autoclean
          sudo add-apt-repository ppa:ondrej/php
          sudo apt-get update
          sudo apt-get install php7.4 -y
          sudo apt-get install php7.4-cli php7.4-common php7.4-pgsql php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-fpm php7.4-intl php7.4-simplexml  php7.4-gd php7.4-mcrypt php7.4-soap php7.4-bcmath libapache2-mod-php7.4 php7.4-xml php7.4-common php7.4-cli php7.4-curl php7.4-intl php7.4-xmlrpc php7.4-json php7.4-zip zip unzip -y
          sudo systemctl restart apache2
          apt-get install composer -y
          cd suitecrm/
          composer install
          clear
          clear
          sudo /home/ubuntu/menu.sh
          ;;
        3)
          clear
          echo "Instalando Apache:"
          sudo apt-get install apache2 -y
          clear
          opcion=0
          ;;
        4)
          clear
          sudo apt install mysql-server -y
          sudo mysql -u root < script.sql
          sudo systemctl restart apache2
          clear
          sudo /home/ubuntu/menu.sh
          ;;
        5)
          clear
          cd /var/www/suitecrm/
          sudo chown -R www-data:www-data .
          sudo chmod -R 755 .
          sudo chmod -R 775 cache custom modules themes data upload
          sudo chmod 775 config_override.php 2>/dev/null
          sudo a2ensite suitecrm.conf
          sudo systemctl restart apache2
          sudo a2dissite 000-default.conf
          sudo systemctl restart apache2
          clear
          sudo /home/ubuntu/menu.sh
          ;;
        0)
          clear
          echo "Saliendo del menu..."
          sleep 5
          $opcion=0
          ;;
        *)
          echo "Opcion no existe." 
          ;;
      esac
      
done

echo ""

clear
