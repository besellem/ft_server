# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 15:25:25 by besellem          #+#    #+#              #
#    Updated: 2021/02/19 00:43:43 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster-slim

# Get updates & install needed packages
RUN apt-get update -y && apt-get install -y \
						nginx curl openssl mariadb-server php php-fpm \
						php-cli php-mysql php-cli php-mbstring zsh git

WORKDIR /tmp
COPY ./srcs .
ENTRYPOINT ["bash", "setup.sh"]

EXPOSE 80
EXPOSE 443
