# ---------------------------------------------
# Dockerfile for Laravel + PostgreSQL on Render
# ---------------------------------------------

# 1️⃣ Use official PHP CLI image
FROM php:8.2-cli

# 2️⃣ Install system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git postgresql-client \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3️⃣ Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 4️⃣ Set working directory
WORKDIR /app

# 5️⃣ Copy all project files
COPY . .

# 6️⃣ Make wait-for-db.sh executable
RUN chmod +x wait-for-db.sh

# 7️⃣ Install Laravel dependencies
RUN composer install --no-dev --optimize-autoloader

# 8️⃣ Expose port for Render
EXPOSE 10000

# 9️⃣ Start Laravel: wait for DB, run migrations & seeders, then start server
CMD ["./wait-for-db.sh"]
