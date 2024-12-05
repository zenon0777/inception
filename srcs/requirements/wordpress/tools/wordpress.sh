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
#wp config create --allow-root --dbname=$DB_NAME --dbuser=$USER_NAME --dbpass=$USER_PASSWORD --dbhost=mariadb --extra-php <<PHP
#define('WP_REDIS_CLIENT', 'predis');
#define('WP_REDIS_HOST', 'redis');
#define('WP_REDIS_PORT', '6379');
#PHP

wp config set DB_NAME $DB_NAME --allow-root
wp config set DB_USER $USER_NAME --allow-root
wp config set DB_PASSWORD $USER_PASSWORD --allow-root
wp config set DB_HOST mariadb --allow-root

wp core install --url=https://164.90.130.160 --title="digitparadise" --admin_user=$admin --admin_password=$admin_pass  --admin_email=info@wp-cli.org --allow-root

wp user create $wp_usr editor@wp-cli.org --user_pass=$usr_pass --role=editor --allow-root

wp plugin install redis-cache --activate --allow-root

wp redis enable --allow-root
}
fi
chown -R www-data:www-data /var/site/html/
chmod -R 777 /var/site/html/
kill $(cat /run/php/php7.4-fpm.pid)

/usr/sbin/php-fpm7.4 -F
