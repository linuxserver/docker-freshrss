FROM lsiobase/nginx:3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG FRESHRSS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	php7-ctype \
	php7-curl \
	php7-dom \
	php7-gmp \
	php7-iconv \
	php7-intl \
	php7-mysqli \
	php7-mysqlnd \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pgsql \
	php7-sqlite3 \
	php7-zip \
	sqlite && \
 echo "**** Tag this image with current version ****" && \
 if [ -z ${FRESHRSS_RELEASE+x} ]; then \
	FRESHRSS_RELEASE=$(curl -sX GET "https://api.github.com/repos/FreshRSS/FreshRSS/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 echo ${FRESHRSS_RELEASE} > /version.txt

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
