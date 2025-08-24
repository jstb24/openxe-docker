#!/bin/bash

# Lade das neueste Release von GitHub
wget https://github.com/OpenXE-org/OpenXE/archive/refs/tags/V.1.12.zip -O openxe.zip

# Entpacke und bereite die Installation vor
unzip openxe.zip
mv OpenXE-* openxe
rm openxe.zip

# Setze Rechte
chown -R www-data:www-data openxe
chmod -R 775 openxe

docker compose build
docker compose up -d

