#!/bin/bash
if [ -f "/var/www/freshrss/index.php" ]; then
echo "checking for updates"
cd /var/www/freshrss
git pull
else
echo "fetching freshress files"
git clone https://github.com/marienfressinaud/FreshRSS/ /var/www/freshrss
fi
crontab -u abc /cronfile/cronjob
chown -R abc:abc /var/www/freshrss

