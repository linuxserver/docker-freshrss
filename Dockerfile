# set base os
FROM linuxserver/baseimage
MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

# Set the locale
RUN locale-gen en_US.UTF-8

# update apt and install dependencies
RUN apt-get update && \
apt-get install \
git-core \
apache2 \
php5 \
php5-common \
php5-curl \
php5-mysql -qy && \

# clean up
cd / && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# set volume
VOLUME /config

# set ports
EXPOSE 80

#Adding Custom files
RUN mkdir -p /cronfile /defaults
ADD defaults/ defaults
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# Enable apache mods.
a2enmod php5 && \
a2enmod rewrite && \
sed -i "s#/var/www#/config#g" /etc/apache2/apache2.conf && \

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini && \
sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini && \

# mv config files
mv /defaults/envvars /etc/apache2/envvars && \
mv /defaults/apache-config.conf  /etc/apache2/sites-enabled/000-default.conf && \
mv /defaults/cronjob /cronfile/cronjob && \

#set permissions on cronfile for abc
chown -R abc:abc /cronfile
