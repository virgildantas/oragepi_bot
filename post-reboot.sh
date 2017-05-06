#!/bin/bash
apt-get update -y
apt-get upgrade -y
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --rails
apt-get install wget -y
mkdir webmin
cd webmin
wget http://prdownloads.sourceforge.net/webadmin/webmin-1.831.tar.gz
tar -zxvf webmin-1.831.tar.gz
cd webmin-1.831
echo "AGORA VAMOS CONFIGURAR O WEBMIN, PRESTE ATENÇÃO NA INSTALAÇÃO"
SLEEP(5) 
./setup.sh

echo "AGORA VAMOS INSTALAR O TRANSMISSION" 
SLEEP(5) 
apt-get install transmission-daemon transmission-web -y

