![https://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/freshrss

A free, self-hostable aggregator for rss feeds. http://freshrss.org/

## Usage

```
docker create --name=freshrss -v <path to data>:/config -e PGID=<gid> -e PUID=<uid> -p 80:80 linuxserver/freshrss
```

**Parameters**

* `-p 80` - the port(s)
* `-v /config` - local storage for freshrss site files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it freshrss /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

Create a user and database in your mysql/mariadb server (not root) and then follow the setup wizard in the webui. Use the IP address for "host" of your database server.


## Updates

* Upgrade to the latest version simply `docker restart freshrss`.
* To monitor the logs of the container in realtime `docker logs -f freshrss`.



## Versions
+ **23.11.15:** Update dependencies to latest requirements
+ **21.08.15:** Initial Release. 

