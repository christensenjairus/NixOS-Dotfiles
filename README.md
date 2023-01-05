# DotFiles for Linux Workstation
### NixOS + AwesomeWM + LightDM + X11 + i3lock
#### Desktop on login
![Desktop on login](https://github.com/christensenjairus/NixOS-Config/blob/main/README_images/desktop%20screenshot.png)
#### Desktop on blank tag
![Desktop on blank tag](https://github.com/christensenjairus/NixOS-Config/blob/main/README_images/desktop%20screenshot2.png)
#### Personizable & Dynamic Keybindings Popup
![AwesomeWM Keybindings](https://github.com/christensenjairus/NixOS-Config/blob/main/README_images/keybindings.png)
#### Right Click Menu on Desktop
![AwesomeWM Menu](https://github.com/christensenjairus/NixOS-Config/blob/main/README_images/menu%20screenshot.png)
* * *
## Procedure
1) Install the gnome version of NixOS and don't do anything special.
2) Once booted, install git and clone this repo.
3) Copy all folders in the `.config` directory to your `.config` directory
4) Copy the remaining files starting with . to your home directory
      - Use the files in the `etc.nixos` directory to help you set up a config that will work for your hardware.
      - **NOTE: Do not edit your existing `hardware-configuration.nix` file because this may be different on many machines. Do not use mine**
      - You can directly copy `user-pkgs.nix` and `root-pkgs.nix`, but do edits to your `configuration.nix` by hand. 
5) clone oh-my-zsh into `~/.oh-my-zsh` <TODO>
6) clone powerlevel10k by running the oh-my-zsh installation script. <TODO>
5) Build the system (this will take a long time with how many packages there are in `user-pkgs.nix`) and reboot.
6) See notes for tidbits of useful info.

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
