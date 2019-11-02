#!/bin/bash

#Install icaros in icaros-light_2.2.9-1/usr/lib/icaros and execute this script

mv icaros-light_2.2.9-1/usr/lib/icaros/System/Opus5 usr/lib/icaros/System/Opus5-base
mkdir icaros-light_2.2.9-1/usr/lib/icaros/System/Opus5

mv icaros-light_2.2.9-1/usr/lib/icaros/Prefs/Env-Archive usr/lib/icaros/Prefs/Env-Archive-base
mkdir icaros-light_2.2.9-1/usr/lib/icaros/Prefs/Env-Archive

git checkout icaros-light_2.2.9-1/usr/lib/icaros
