#!/bin/bash

docker run -d --name=plex --net=host -e PLEX_CLAIM=claim-weftLwPbvXcCE5fKyRuB -e PUID=1000 -e PGID=1000 -v /mnt/plex/plexdata:/config -v '/mnt/plex/TV Shows:/tv' -v /mnt/plex/Movies:/movies --restart unless-stopped lscr.io/linuxserver/plex:latest
