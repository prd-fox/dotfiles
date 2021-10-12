#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo bash get-docker.sh
sudo usermod -aG docker $(whoami)
sudo reboot
