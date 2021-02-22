# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 15:25:25 by besellem          #+#    #+#              #
#    Updated: 2021/02/22 11:41:00 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster-slim

# Get updates & install needed packages
RUN apt-get update -y && apt-get install -y \
						nginx curl openssl mariadb-server zsh git vim \
						php7.3 php7.3-fpm php7.3-cli php7.3-mysql php7.3-cli php7.3-mbstring

WORKDIR /tmp
COPY ./srcs .
ENTRYPOINT ["bash", "setup.sh"]
