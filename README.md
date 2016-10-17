[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/freshrss
[![](https://images.microbadger.com/badges/version/linuxserver/freshrss.svg)](https://microbadger.com/images/linuxserver/freshrss "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/freshrss.svg)](http://microbadger.com/images/linuxserver/freshrss "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/freshrss.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/freshrss.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-freshrss)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-freshrss/)
[hub]: https://hub.docker.com/r/linuxserver/freshrss/

[FreshRSS][freshrssurl] is a free, self-hostable aggregator for rss feeds

[![freshrss](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/freshrss-banner.png)][freshrssurl]
[freshrssurl]: https://freshrss.org/

## Usage

```
docker create \
--name=freshrss \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-p 80:80 \
linuxserver/freshrss
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 80` - the port(s)
* `-v /config` - local storage for freshrss site files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it freshrss /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

Create a user and database in your mysql/mariadb server (not root) and then follow the setup wizard in the webui. Use the IP address for "host" of your database server.

## Updates

* Upgrade to the latest version simply `docker restart freshrss`.
* To monitor the logs of the container in realtime `docker logs -f freshrss`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' freshrss`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/freshrss`

## Versions

+ **14-10-16:** Add version layer information.
+ **08.10.16:** Add Sqlite support for standalone operation. 
+ **27.09.16:** Fix for cron job.
+ **11.09.16:** Add layer badges to README.
+ **23.11.15:** Update dependencies to latest requirements
+ **21.08.15:** Initial Release.
