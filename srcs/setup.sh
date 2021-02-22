#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 15:21:32 by besellem          #+#    #+#              #
#    Updated: 2020/12/09 14:10:51 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

## START
mkdir /var/www/website

# Create website folder (where websites will be put on)
# echo "<?php phpinfo(); ?>" >> /var/www/website/index.php


# SSL cert
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/website.pem -keyout /etc/nginx/ssl/website.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=ben/CN=website"


# Copy & link server config file
# cp server_autoindex_on /etc/nginx/sites-available/website
rm /etc/nginx/sites-enabled/default
cp /tmp/config_autoindex_on /etc/nginx/sites-available/config
ln -s /etc/nginx/sites-available/config /etc/nginx/sites-enabled/


# Extract phpmyadmin & move the folder into /var/www/website/
tar -xf phpMyAdmin-5.0.4-english.tar.gz
rm phpMyAdmin-5.0.4-english.tar.gz
mv phpMyAdmin-5.0.4-english phpmyadmin
mv phpmyadmin /var/www/website/
mv /tmp/config.inc.php /var/www/website/phpmyadmin


# Extract wordpress & move the folder into /var/www/website/
tar -xf wordpress-5.6.tar.gz
rm wordpress-5.6.tar.gz
mv wordpress /var/www/website/
mv /tmp/wp-config.php /var/www/website/wordpress


# Grant rights
chown -R www-data:www-data /var/www/website/
chmod 755 -R /var/www/*
chmod 755 /tmp/autoindex.sh


# -- Start Services --
# MySQL
service mysql start

# Wordpress database config
echo "create database wordpress;" | mysql -u root
echo "create user 'wordpress'@'%';" | mysql -u root
echo "grant all privileges on wordpress.* to 'wordpress'@'%' with grant option;" | mysql -u root
echo "flush privileges;" | mysql -u root


# PHP
# service nginx status
# nginx -t
service php7.3-fpm start
service nginx start

# Install oh-my-zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "alias c=clear" >> ~/.zshrc


## END
# Check the database installation
echo "show databases;" | mysql -u root

# Open the container's terminal
zsh
