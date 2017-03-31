#!/bin/bash
set -e

# check if ENV is set, or die
php /var/www/bin/console cache:clear -n

# install assets
#php /var/www/bin/console assets:install -vvv -n

# apply db migrations
#php /var/www/bin/console doctrine:migrations:migrate -n --allow-no-migration


echo 'fix permisions';
chown -R www-data: .

exec "$@"
