#!/bin/bash

app_name="adam-auto-deployment"

sudo yum upgrade -y

yum install epel-release -y

# Basic Tools
yum install net-tools fish vim lsof git wget zip unzip telnet mailx -y

# PHP
yum install centos-release-scl -y
yum install php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum-config-manager --enable remi-php73 -y
yum install php-fpm php-mysqlnd php-zip php-devel php-gd php-mcrypt php-mbstring php-curl php-xml php-pear php-bcmath php-json php-redis -y


# Composer
cd /

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

php composer-setup.php

php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/bin/composer

# Swoole
yum install php-pear php-devel -y
pecl install swoole
echo "extension=swoole.so" > /etc/php.d/20-swoole.ini

# Docker
yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --disable docker-ce-edge
yum install docker-ce
systemctl start docker

chkconfig docker up

# Docker compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /bin/docker-compose
chmod +x /bin/docker-compose

# mail
service postfix restart

# go
cd /
wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
tar -C /bin -xzf go1.12.6.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
rm -rf go1.12.6.linux-amd64.tar.gz

# vim-go 
# https://github.com/fatih/vim-go
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/fatih/vim-go.git ~/.vim/plugged/vim-go

echo "call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
call plug#end()
let g:go_version_warning = 0
" >  ~/.vimrc

# vim monokai editor style
# https://github.com/sickill/vim-monokai
cd ~/.vim
mkdir colors
cd colors
wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
echo "syntax enable
colorscheme monokai" >> ~/.vimrc


echo "All is done!~👍"
