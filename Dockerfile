# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 15:25:25 by besellem          #+#    #+#              #
#    Updated: 2020/12/08 15:32:49 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster-slim

# Get updates
RUN apt-get update -y

# Install needed packages
RUN apt-get update -y && apt-get install -y \
						nginx wget openssl mariadb-server \
						php php-fpm php-cli php-mysql php-cli php-mbstring

WORKDIR /tmp
COPY srcs .
ENTRYPOINT ["bash", "setup.sh"]
CMD ["bash"]

###
# COPY srcs /tmp
# ENTRYPOINT bash /tmp/setup.sh
# CMD bash /tmp/setup.sh
###

EXPOSE 80
EXPOSE 443
