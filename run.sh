#!/bin/bash

target_dir="/var/www/html"

if [ "$(ls -A $folder_path)" ]; then
    echo "Serving Folder is not empty running PHP Artisan"
    # /usr/local/bin/apache2-foreground
    cd /var/www/html && php artisan serve --host=0.0.0.0
else
    echo "Serving Folder is empty creating laravel from scratch"
    cd /var/www/ && composer create-project laravel/laravel html
    # /usr/local/bin/apache2-foreground
    cd /var/www/html && php artisan serve --host=0.0.0.0
fi