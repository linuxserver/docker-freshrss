# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.17

# set version label
ARG BUILD_DATE
ARG VERSION
ARG FRESHRSS_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-gmp \
    php81-iconv \
    php81-intl \
    php81-mysqli \
    php81-mysqlnd \
    php81-pdo_mysql \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-pgsql \
    php81-sqlite3 \
    php81-zip \
    sqlite && \
  echo "**** install app ****" && \
  if [ -z ${FRESHRSS_RELEASE+x} ]; then \
    FRESHRSS_RELEASE=$(curl -sX GET "https://api.github.com/repos/FreshRSS/FreshRSS/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  mkdir -p \
    /app/www && \
  curl -o \
    /tmp/freshrss.tar.gz -L \
    "https://github.com/FreshRSS/FreshRSS/archive/${FRESHRSS_RELEASE}.tar.gz" && \
  tar xf \
    /tmp/freshrss.tar.gz -C \
    /app/www --strip-components=1 && \
  sed -i "s|'disable_update' => false,|'disable_update' => true,|g" \
    /app/www/config.default.php && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
