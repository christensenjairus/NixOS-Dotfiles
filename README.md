# NixOS-Config
## Desktop Workstation
### NixOS + AwesomeWM + LightDM + X11 + i3lock
#### Desktop on login
![Desktop on login](https://github.com/christensenjairus/NixOS-Config/blob/main/desktop%20screenshot.png)
#### Desktop on blank tag
![Desktop on blank tag](https://github.com/christensenjairus/NixOS-Config/blob/main/desktop%20screenshot2.png)
#### Personizable & Dynamic Keybindings Popup
![AwesomeWM Keybindings](https://github.com/christensenjairus/NixOS-Config/blob/main/keybindings.png)
#### Right Click Menu on Desktop
![AwesomeWM Menu](https://github.com/christensenjairus/NixOS-Config/blob/main/menu%20screenshot.png)
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
