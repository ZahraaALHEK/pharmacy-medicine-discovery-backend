#!/bin/sh
# Wait for PostgreSQL to be ready

set -e

host="dpg-d55homer433s73dksbs0-a"
port="5432"

echo "Waiting for PostgreSQL at $host:$port..."

# Loop until PostgreSQL is ready
until pg_isready -h "$host" -p "$port"; do
  echo "PostgreSQL is not ready yet... waiting 2 seconds"
  sleep 2
done

echo "PostgreSQL is ready! Running migrations and seeders..."

# Run migrations and seeders
php artisan migrate --force
php artisan db:seed --class=AdminSeeder

# Start Laravel built-in server
php -S 0.0.0.0:10000 -t public
