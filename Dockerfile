FROM php:8.1.1-fpm

ENV BRANCH main

#FROM devilbox/php-fpm-8.1:latest

RUN echo "**** Updating packages... ****" \
&& apt update -y && apt upgrade -y \
&& echo "**** Done! ****"

RUN echo "**** Installing symfony... ****" \
&& apt install curl wget unzip git -y \
&& wget https://get.symfony.com/cli/installer -O - | bash \
&& mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
&& curl -sS https://getcomposer.org/installer -o composer-setup.php \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& echo "**** Done! ****"
#&& composer install

RUN echo "**** Installing streamrip... ****" \
&& apt install python3 python3-venv python3-pip -y \
&& python3 -m pip install streamrip simple-term-menu --upgrade \
&& echo "**** Done! ****"
COPY streamrip-config.toml /root/.config/streamrip/config.toml

RUN echo "**** Cleaning up... ****" \
&& apt-get clean -y \
&& echo "**** Done! ****"

VOLUME /config
VOLUME /download

EXPOSE 8000

#CMD ["symfony", "server:start"]

COPY ./init.sh ./
CMD ["sh", "./init.sh"]