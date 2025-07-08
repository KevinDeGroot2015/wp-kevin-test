# Dockerfile

FROM wordpress:latest

# Installeer mysql client zodat wp db check werkt
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*

# Zet werkdirectory voor consistentie (optioneel)
WORKDIR /var/www/html
