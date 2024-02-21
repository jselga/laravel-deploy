FROM php:8.1-apache
RUN apt update && apt install -y zip && apt install -y unzip && apt install -y git
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN a2enmod rewrite
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=. --filename=composer
RUN mv composer /usr/local/bin/
COPY . /var/www/html
RUN composer install
RUN mv /var/www/html/.env.example /var/www/html/.env
RUN php artisan key:generate
# Permís al directori storage però s'hauria de fer més segur
RUN chmod 777 -R /storage 

EXPOSE 80