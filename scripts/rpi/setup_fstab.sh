#!/bin/bash

UUID="84EE"
FSTAB_ENTRY="UUID=${UUID} /mnt/plex exfat defaults,rw,nofail,umask=000,uid=1000,gid=1000"

ENTRY_EXISTS=$(cat /etc/fstab | grep ${UUID} | wc -l)

if [ ${ENTRY_EXISTS} != "1" ]; then
  sudo echo "${FSTAB_ENTRY}" >> /etc/fstab
fi
