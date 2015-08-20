#!/bin/bash
if [ -f "/config/freshrss/index.php" ]; then
echo "checking for updates"
cd /config/freshrss
git pull
else
echo "fetching freshress files"
git clone https://github.com/marienfressinaud/FreshRSS/ /config/freshrss
fi
crontab -u abc /cronfile/cronjob
chown -R abc:abc /config
