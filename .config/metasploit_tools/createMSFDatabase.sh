#!/bin/sh
echo Creating user msf
echo "SET ROLE PASSWORD AS 'msf'"
sudo runuser -u postgres -- createuser msf -P -S -R -D; # creates msf postgres user and asks you for a password
echo Creating database msf
sudo runuser -u postgres -- createdb -O msf msf

