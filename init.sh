#!/bin/bash

echo "[+] Executing initialization sql request..."
sudo mysql -u root < ./sql/init/creating.sql > /dev/null
echo "[+] Done"