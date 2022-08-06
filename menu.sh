#! /bin/bash
usuario=$(whoami)
opcion=1
clear

echo "---------- MENU INSTALACION DE SUITECRM ----------"
echo "=================================================="
echo ""
echo "Siga los siguientes pasos en el orden establecido:"
echo "--------------------------------------------------"
echo "1. Instalacion de GIT"
echo "2. Descarga de archivos SuiteCRM"
echo "3. Instalacion de Composer"
echo "4. Instalacion de Apache"
echo "5. Instalacion de php7.4 y modulos adicionales"
echo "6. Instalacion de MySQL"
echo "7. Configuraciones adicionales"
echo "0. Salir"
echo ""
echo "SELECCIONE OPCION:"
read opcion

while [ $opcion -ne 0 ]; do

      case $opcion in
        1)
          clear
          echo "Iniciando instalacion de GIT";
          sudo apt-get update
          sudo apt-get install git -y
          clear
          opcion=0
          ;;
        2)
          clear
          echo "Iniciando descarga de ficheros y directorios de SuiteCRM:"
          sudo git clone https://github.com/salesagility/SuiteCRM.git suitecrm
          sudo chmod -R 777 suitecrm
          sudo mv suitecrm /var/www/
          cd /var/www/
          sudo chown -R www-data.www-data suitecrm
          sudo chmod -R 775 suitecrm
          clear
          opcion=0
          ;;
        3)
          clear
          echo "Iniciando instalacion de composer:"
          sudo apt-get install composer -y
          cd /var/www/suitecrm/
          sudo composer install
          clear
          opcion=0
          ;;
        4)
          clear
          echo "Instalando Apache:"
          sudo apt-get install apache2 -y
          clear
          opcion=0
          ;;
        5)
          clear
          sudo cp php.ini temp1.ini
          sudo apt remove php8*
          sudo apt-get purge php*
          sudo apt-get autoremove
          sudo apt-get autoclean
          sudo cp temp1.ini php.ini
          sudo add-apt-repository ppa:ondrej/php
          sudo apt-get update
          sudo apt-get install php7.4 -y
          sudo apt-get install php7.4-cli php7.4-common php7.4-pgsql php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-fpm php7.4-intl php7.4-simplexml  php7.4-gd php7.4-mcrypt php7.4-soap php7.4-bcmath libapache2-mod-php7.4 php7.4-xml php7.4-common php7.4-cli php7.4-curl php7.4-intl php7.4-xmlrpc php7.4-json php7.4-zip zip unzip -y
          sudo systemctl restart apache2
          clear
          opcion=0
          ;;
        6)
          clear
          sudo apt install mysql-server -y
          sudo mysql -u root < script.sql
          sudo systemctl restart apache2
          clear
          opcion=0
          ;;
        7)
          clear
          cd /home/ubuntu/sistemasAbiertos
          sudo cp php.ini temp1.ini
          sudo chmod -R 777 php.ini
          sudo mv php.ini /etc/php/7.4/apache2/php.ini
          sudo cp temp1.ini php.ini
          sudo chmod -R 777 php.ini
          sudo systemctl restart apache2
          sudo cp suitecrm.conf temp2.conf
          sudo chmod -R 777 suitecrm.conf
          sudo mv suitecrm.conf /etc/apache2/sites-available/suitecrm.conf
          sudo cp temp2.conf suitecrm.conf
          sudo chmod -R 777 suitecrm.conf
          sudo systemctl restart apache2
          sudo a2ensite suitecrm.conf
          sudo systemctl restart apache2
          sudo a2dissite 000-default.conf
          sudo systemctl restart apache2
          clear
          opcion=0
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
