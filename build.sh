#!/bin/bash

sudo chmod -R g+rw icaros-light_2.2.9-1/usr/lib/icaros/*
sudo find icaros-light_2.2.9-1/usr/lib/icaros/ -type d -exec chmod g+x {} \;
sudo chmod -R g+rx icaros-lxde-light_0.1-1/usr/lib/icaros/S/*.sh
sudo chmod -R g+rx icaros-light_2.2.9-1/usr/lib/icaros/S/*.sh
sudo chmod g+rx icaros-light_2.2.9-1/usr/lib/icaros/icaros
sudo chmod g+rx icaros-light_2.2.9-1/usr/lib/icaros/S/icaros_refreshd
sudo chmod g+xt icaros-lxde-light_0.1-1/usr/lib/icaros/S/icaros_daemon

dpkg-deb --build icaros-lxde-light_0.1-1
dpkg-deb --build icaros-light_2.2.9-1

