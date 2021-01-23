FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.13

# set version label
ARG BUILD_DATE
ARG VERSION
ARG FRESHRSS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

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
 echo "**** install app ****" && \
 if [ -z ${FRESHRSS_RELEASE+x} ]; then \
	FRESHRSS_RELEASE=$(curl -sX GET "https://api.github.com/repos/FreshRSS/FreshRSS/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	/usr/share/webapps/freshrss && \
 curl -o \
	/tmp/freshrss.tar.gz -L \
	"https://github.com/FreshRSS/FreshRSS/archive/${FRESHRSS_RELEASE}.tar.gz" && \
 tar xf \
	/tmp/freshrss.tar.gz -C \
	/usr/share/webapps/freshrss --strip-components=1 && \
 sed -i "s|'disable_update' => false,|'disable_update' => true,|g" \
	/usr/share/webapps/freshrss/config.default.php && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
