#!/usr/bin/env bash
set -e

# Wacht tot de database reageert
until wp db check --quiet; do
  echo "⏳ Wachten op database..."; sleep 2;
done

# Installeer WordPress (overslaan als het al bestaat)
if ! wp core is-installed --quiet; then
  wp core install \
    --url="http://localhost:8080" \
    --title="Demo‑site" \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@example.com \
    --skip-email
fi

# Dummy‑content genereren (FakerPress)
wp plugin install fakerpress --activate
wp fakerpress post generate --count=20 --status=publish
wp fakerpress term generate --count=10 --taxonomy=category
