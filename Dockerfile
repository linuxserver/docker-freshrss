# set base os
FROM phusion/baseimage:0.9.17
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive 
ENV HOME /root 
ENV TERM screen
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# set ports
EXPOSE 80

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

# Enable apache mods.
RUN a2enmod php5 && \
a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php5/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php5/apache2/php.ini

# add config files
RUN mkdir -p /cronfile 
ADD defaults/envvars /etc/apache2/envvars
ADD defaults/apache-config.conf  /etc/apache2/sites-enabled/000-default.conf
ADD defaults/cronjob /cronfile/cronjob

#Adduser abc
RUN useradd -u 911 -U -s /bin/false abc
RUN usermod -G users abc
RUN chown -R abc:abc /cronfile

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
