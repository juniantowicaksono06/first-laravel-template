#!/bin/bash

target_dir="/var/www/html"

if [ "$(ls -A $folder_path)" ]; then
    echo "Serving Folder is not empty running Apache2"
    /usr/local/bin/apache2-foreground
else
    echo "Serving Folder is empty creating laravel from scratch"
    cd /tmp && composer create-project laravel/laravel laravel1 && mv /tmp/laravel1/* /var/www/html
    /usr/local/bin/apache2-foreground