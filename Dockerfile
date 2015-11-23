# set base os
FROM linuxserver/baseimage.apache
MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

# Set correct environment variables
ENV APTLIST="git-core php5-gmp php5-intl php5-mysqlnd php5-pgsql"
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"

# Set the locale
RUN locale-gen en_US.UTF-8

# update apt and install dependencies
RUN apt-get update && \
apt-get install \
$APTLIST -qy && \

# cleanup 
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files 
ADD defaults/ /defaults/
ADD cron/ /etc/cron.d/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# expose ports
EXPOSE 80

# set volumes
VOLUME /config
