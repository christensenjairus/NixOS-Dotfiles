# NixOS-Config
## Desktop Workstation
### NixOS + AwesomeWM + LightDM + X11 + i3lock
* * *
## Notes:
### Onedrive
Run these commands once to get the onedrive daemon started
```bash
onedrive --confdir=$HOME/.config/onedrive-0
systemctl --user enable onedrive@onedrive-0.service
systemctl --user start onedrive@onedrive-0.service
```
### Metasploit
In msfconsole, run this command once to connect to the database
```bash
db_connect --name msf msf:msf@localhost/msf
```
After the first use, only the following command is necessary
```bash
db_connect msf
```
