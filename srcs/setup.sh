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
# Create website folder (where websites will be put on)
mkdir /var/www/website
mv ./test/* /var/www/website/


# SSL cert
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/website.pem -keyout /etc/nginx/ssl/website.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=ben/CN=website"


# Copy & link server config file
# cp server_autoindex_on /etc/nginx/sites-available/website
rm /etc/nginx/sites-enabled/default
mv ./config /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/config /etc/nginx/sites-enabled/


# Extract phpmyadmin & move the folder into /var/www/website/
tar -xf phpMyAdmin-5.0.4-english.tar.gz
rm phpMyAdmin-5.0.4-english.tar.gz
mv phpMyAdmin-5.0.4-english phpmyadmin
mv phpmyadmin /var/www/website/


# Extract wordpress & move the folder into /var/www/website/
tar -xf wordpress-5.6.tar.gz
rm wordpress-5.6.tar.gz
mv wordpress /var/www/website/


# Grant rights
chown -R www-data:www-data /var/www/website/*
chmod -R /var/www/website/*


# -- Start Services --
# MySQL
service mysql start
service php7.3-fpm start
service nginx start


# Wordpress database config
echo "create database wordpress;" | mysql -u root
echo "create user 'wordpress'@'127.0.0.1';" | mysql -u root
echo "grant all privileges on wordpress.* to 'wordpress'@'127.0.0.1' with grant option;" | mysql -u root
echo "flush privileges;" | mysql -u root


# Check the databases installed
echo "show databases;" | mysql -u root
echo "SELECT user FROM mysql.user;" | mysql -u root

# PHP
#service nginx status
#nginx -t


# Install oh-my-zsh
# chsh -s $(which zsh)
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# echo "alias c=clear" >> ~/.zshrc


## END
# Open the container's terminal
zsh
