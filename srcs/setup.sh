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
# Create localhost folder (where websites will be put on)
mkdir /var/www/localhost
mv ./test/ /var/www/localhost/


# SSL cert
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=ben/CN=localhost"


# Copy & link server config file
# cp server_autoindex_on /etc/nginx/sites-available/localhost
mv ./config /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/config /etc/nginx/sites-enabled/


# Extract phpmyadmin & move the folder into /var/www/localhost/
tar -xf phpMyAdmin-5.0.4-english.tar.gz
rm phpMyAdmin-5.0.4-english.tar.gz
mv phpMyAdmin-5.0.4-english phpmyadmin
mv phpmyadmin /var/www/localhost/test/


# Extract wordpress & move the folder into /var/www/localhost/
tar -xf wordpress-5.6.tar.gz
rm wordpress-5.6.tar.gz
mv wordpress /var/www/localhost/test/


# -- Start Services --
# MySQL
service mysql start


# Wordpress database config
echo "create database wordpress;" | mysql -u root
echo "create user 'wordpress'@'127.0.0.1';" | mysql -u root

# Check the databases installed
echo "SHOW DATABASES;" | mysql -u root
echo "SELECT user FROM mysql.user;" | mysql -u root


# Nginx
service nginx reload
service nginx configtest
service nginx start
service nginx status
nginx -t


# PHP
service php7.3-fpm start
service php7.3-fpm status


# Install oh-my-zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "alias c=clear" >> ~/.zshrc


# Restart services
service mysql restart
service php7.3-fpm restart


## END
# Open the container's terminal
zsh
