#!/usr/bin/env bash
set -e

cd /var/www/html

# Download WordPress als het nog niet aanwezig is
if [ ! -f wp-load.php ]; then
  echo "⬇️ WordPress downloaden..."
  wp core download --allow-root
fi

# Wacht tot de database klaar is
echo "⏳ Wachten op database (MariaDB)..."
for i in {1..15}; do
  if mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; then
    echo "✅ Database is bereikbaar."
    break
  fi
  echo "⏳ Poging $i... database nog niet klaar."
  sleep 2
  if [ $i -eq 15 ]; then
    echo "❌ Database blijft onbereikbaar. Check je configuratie of logs."
    exit 1
  fi
done

# Installeer WordPress als nog niet gedaan
if ! wp core is-installed --allow-root; then
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

# Dummy-content
echo "🎨 Dummy content aanmaken met FakerPress..."
wp plugin install fakerpress --activate --allow-root
wp fakerpress post generate --count=20 --status=publish --allow-root
wp fakerpress term generate --count=10 --taxonomy=category --allow-root
