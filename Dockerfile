FROM lsiobase/alpine.nginx:3.6
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	git \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-gmp \
	php7-iconv \
	php7-intl \
	php7-mbstring \
	php7-mysqli \
	php7-mysqlnd \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pgsql \
	php7-sqlite3 \
	php7-xml \
	php7-zip \
	php7-zlib \
	sqlite

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
