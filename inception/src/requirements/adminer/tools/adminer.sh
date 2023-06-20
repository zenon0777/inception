#! /bin/bash

mv latest.php /var/adminer/index.php

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:663/g' /etc/php/7.4/fpm/pool.d/www.conf

service php7.4-fpm start

kill $(cat /run/php/php7.4-fpm.pid)

/usr/sbin/php-fpm7.4 -F -R
