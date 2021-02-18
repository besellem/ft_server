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
# Alias
echo "alias c=clear" >> ~/.bashrc
echo "alias l='ls -la'" >> ~/.bashrc

# Create localhost folder (where websites will be put on)
mkdir /var/www/localhost

# Copy & link server config file
cp server_autoindex_on /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/


# Extract phpmyadmin & move the folder into /var/www/localhost/
tar -xf phpMyAdmin-5.0.4-english.tar.gz && rm phpMyAdmin-5.0.4-english.tar.gz
mv phpMyAdmin-5.0.4-english phpmyadmin && mv phpmyadmin /var/www/localhost/


# Extract wordpress & move the folder into /var/www/localhost/
tar -xf wordpress-5.6.tar.gz && rm wordpress-5.6.tar.gz
mv wordpress /var/www/localhost/


# -- Start Services --
# Wordpress & mysql
service mysql start
echo "create database wordpress;" | mysql -u root
echo "create user 'wordpress'@'localhost';" | mysql -u root

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
/etc/init.d/php7.3-fpm start
/etc/init.d/php7.3-fpm status


mv test/index.php /var/www/localhost/


## END
# Open the container's terminal
bash
