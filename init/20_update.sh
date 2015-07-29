#!/bin/bash

apt-get update -qq
apt-get --only-upgrade install \
git-core \
apache2 \
php5 \
php5-common \
php5-curl \
php5-mysql -qqy
