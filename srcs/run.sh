# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    run.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: besellem <besellem@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/09 15:48:05 by besellem          #+#    #+#              #
#    Updated: 2021/02/22 20:01:29 by besellem         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Docker clean build
clear
docker rm bs_test
docker rmi bs
docker build -t bs .
docker run -it -p 80:80 -p 443:443 bs
