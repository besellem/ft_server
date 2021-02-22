# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    autoindex.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/22 11:38:38 by besellem          #+#    #+#              #
#    Updated: 2021/02/22 12:04:29 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

auto_on=$(cat /etc/nginx/sites-available/config | grep "autoindex")

if [ "$auto_on" = "" ]; then
	echo "autoindex is off, turning it on..."
	rm /etc/nginx/sites-available/config
	rm /etc/nginx/sites-enabled/config
	cp /tmp/config_autoindex_on /etc/nginx/sites-available/config
else
	echo "autoindex is on, turning it off..."
	rm /etc/nginx/sites-available/config
	rm /etc/nginx/sites-enabled/config
	cp /tmp/config_autoindex_off /etc/nginx/sites-available/config
fi

ln -s /etc/nginx/sites-available/config /etc/nginx/sites-enabled/
service nginx restart