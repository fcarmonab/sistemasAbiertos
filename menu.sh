#! /bin/bash
usuario=$(whoami)
opcion=1
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
          ;;
        2)
          clear
          echo "Iniciando descarga de ficheros y directorios de SuiteCRM:";
          sudo su
          cd ~
          mkdir tmp
          cd /tmp/
          sudo git clone https://github.com/salesagility/SuiteCRM.git suitecrm
          mv suitecrm /var/www/
          cd /var/www/
          sudo chown -R www-data.www-data suitecrm
          sudo chmod -R 775 suitecrm
          clear
          ;;
        3)
          clear
          echo "Iniciando instalacion de composer:"
          sudo apt-get install composer -y
          cd suitecrm/
          composer install
          clear
          ;;
        4)
          clear
          echo "Instalando Apache:"
          sudo apt-get install apache2 -y
          clear
          ;;
        5)
          clear
          sudo add-apt-repository ppa:ondrej/php
          sudo apt-get update
          sudo apt-get install php7.4 -y
          sudo apt-get install php7.4-cli php7.4-common php7.4-pgsql php7.4-json php7.4-opcache php7.4-mysql php7.4-mbstring php7.4-fpm php7.4-intl php7.4-simplexml  php7.4-gd php7.4-mcrypt php7.4-soap php7.4-bcmath libapache2-mod-php7.4 php7.4-xml php7.4-common php7.4-cli php7.4-curl php7.4-intl php7.4-xmlrpc php7.4-json php7.4-zip zip unzip -y
          sudo systemctl restart apache2
          clear
          ;;
        6)
          clear
          sudo apt install mysql-server -y
          sudo mysql -u root < script.sql
          sudo systemctl restart apache2
          clear
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
