#!/usr/bin/env bash
set -e

# Ga naar de map waar WordPress wordt verwacht
cd /var/www/html

# Download WordPress als het nog niet aanwezig is
if [ ! -f wp-load.php ]; then
  echo "⬇️ WordPress downloaden..."
  wp core download --allow-root
fi

# Wacht tot de database reageert
until mysqladmin ping -h db --silent; do
  echo "⏳ Wachten op database (MariaDB)..."
  sleep 2
done

# Installeer WordPress (overslaan als het al bestaat)
if ! wp core is-installed --quiet --allow-root; then
  echo "⚙️ WordPress installeren..."
  wp core install \
    --url="http://localhost:8080" \
    --title="Demo‑site" \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@example.com \
    --skip-email \
    --allow-root
fi

# Dummy‑content genereren (FakerPress)
echo "🎨 Dummy content aanmaken met FakerPress..."
wp plugin install fakerpress --activate --allow-root
wp fakerpress post generate --count=20 --status=publish --allow-root
wp fakerpress term generate --count=10 --taxonomy=category --allow-root
