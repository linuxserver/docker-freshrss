#!/bin/bash
if [ ! -f "/config/www/freshrss/index.php" ]; then
echo "fetching freshress files"
git clone https://github.com/marienfressinaud/FreshRSS/ /config/www/freshrss
else
echo "checking for updates"
cd /config/www/freshrss
git pull
fi
chown -R abc:abc /config
