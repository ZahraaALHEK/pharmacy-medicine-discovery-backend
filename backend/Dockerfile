# ---------------------------------------------
# Dockerfile for Laravel + PostgreSQL on Render
# ---------------------------------------------

# 1️⃣ Use official PHP CLI image
FROM php:8.2-cli

# 2️⃣ Install necessary system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3️⃣ Install Composer (dependency manager for PHP)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4️⃣ Set working directory inside the container
WORKDIR /app

# 5️⃣ Copy all project files into the container
COPY . .

# 6️⃣ Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# 7️⃣ Expose port for web access (Render will use this)
EXPOSE 10000

# 8️⃣ Start Laravel using PHP built-in server (Production: use proper web server for real production)
CMD ["php", "-S", "0.0.0.0:10000", "-t", "public"]
