#!/bin/sh

while true; do
  out="$(sudo powermetrics -n 1 --samplers smc | egrep -i 'FAN|CPU die|GPU die')"
  clear
  echo "$out"
  sleep 1
done
