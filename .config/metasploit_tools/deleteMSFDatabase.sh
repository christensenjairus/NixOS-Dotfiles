#!/bin/sh
echo Dropping msf user
sudo runuser -u postgres -- dropdb msf;
echo Dropping msf database
sudo runuser -u postgres -- dropuser msf;
