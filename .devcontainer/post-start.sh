#!/usr/bin/env bash
set -e

echo "[1/5] Starting WordPress setup..."

cd /var/www/html

# Download WordPress if not already present
if [ ! -f wp-load.php ]; then
  echo "Downloading WordPress..."
  wp core download --allow-root
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
  echo "Installing WordPress..."
  wp core install \
    --url="http://localhost:8080" \
    --title="Demo site" \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@example.com \
    --skip-email \
    --allow-root
fi

# Generate dummy content using FakerPress
echo "Generating dummy content with FakerPress..."
wp plugin install fakerpress --activate --allow-root
wp fakerpress post generate --count=20 --status=publish --allow-root
wp fakerpress term generate --count=10 --taxonomy=category --allow-root
