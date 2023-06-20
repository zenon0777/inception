#!/bin/bash

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf

service php7.4-fpm start

output=$(ls -A "/var/site/html" 2>/dev/null)

if [[ -z $output ]]; then
{
mkdir -p /var/site/html

cd /var/site/html

wp core download --allow-root

cp /wp-config.php /var/site/html/wp-config.php

wp core install --url=localhost --title="digitparadise" --admin_user=skinnyleg --admin_password=123456 --admin_email=info@wp-cli.org --allow-root

wp user create adaifi adaifi@wp-cli.org --user_pass=123456 --role=editor --allow-root

wp plugin install redis-cache --activate --allow-root

wp redis enable --allow-root

}
fi

kill $(cat /run/php/php7.4-fpm.pid)

/usr/sbin/php-fpm7.4 -F