#!/bin/bash

target_dir="/var/www/html"

if [ "$(ls -A $folder_path)" ]; then
    echo "Serving Folder is not empty running PHP Artisan"
    # /usr/local/bin/apache2-foreground
else
    echo "Serving Folder is empty creating laravel from scratch"
    cd /var/www/ && composer create-project laravel/laravel html
    # /usr/local/bin/apache2-foreground
    cd /var/www/html && composer require inertiajs/inertia-laravel
    php artisan inertia:middleware
    npm install @inertiajs/inertia-react @inertiajs/react @vitejs/plugin-react react react-dom vite
fi

cd /var/www/html && npm run dev & disown
cd /var/www/html && php artisan serve --host=0.0.0.0