#!/usr/bin/env bash
set -e

cd /var/www/html

# Download WordPress indien nodig
if [ ! -f wp-load.php ]; then
  echo "⬇️ WordPress downloaden..."
  wp core download --allow-root
fi

# Wachten op database-bereikbaarheid
echo "⏳ Wachten op database (max 30 seconden)..."
for i in {1..15}; do
  if wp db check --allow-root > /dev/null 2>&1; then
    echo "✅ Database bereikbaar."
    break
  fi
  echo "⏳ Poging $i... database nog niet klaar."
  sleep 2
  if [ $i -eq 15 ]; then
    echo "❌ Fout: Database blijft onbereikbaar. Check je docker-compose config of DB logs."
    exit 1
  fi
done

# Installeer WordPress als het nog niet is gedaan
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

# Dummy content genereren met FakerPress
echo "🎨 Dummy content aanmaken met FakerPress..."
wp plugin install fakerpress --activate --allow-root
wp fakerpress post generate --count=20 --status=publish --allow-root
wp fakerpress term generate --count=10 --taxonomy=category --allow-root
