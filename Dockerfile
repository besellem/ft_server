# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 15:25:25 by besellem          #+#    #+#              #
#    Updated: 2020/12/09 16:28:38 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster-slim

# Get updates & install needed packages
RUN apt-get update -y && apt-get install -y \
						nginx wget openssl mariadb-server \
						php php-fpm php-cli php-mysql php-cli php-mbstring

WORKDIR /tmp
COPY srcs .
ENTRYPOINT ["bash", "setup.sh"]

EXPOSE 80
EXPOSE 443
