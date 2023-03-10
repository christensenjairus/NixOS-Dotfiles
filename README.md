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
1) Install the gnome version of NixOS. For ease of use later, set up your swap partition in the installed (with hibernate if needed).
2) Once booted, install git and clone this repo.
4) Copy the files that start with `.` to your home directory
5) Use the files in the `etc.nixos` directory to help you set up a config that will work for your hardware.
      - **NOTE: Do not edit your existing `hardware-configuration.nix` file because this may be different on many machines.**
      - You can directly copy `user-pkgs.nix` and `root-pkgs.nix`, but do edits to your `configuration.nix` by hand.
5) Build the system (this will take a long time with how many packages there are in `user-pkgs.nix`) and reboot.
6) See notes for tidbits of useful info.

## Notes:
### Power Management
The suspend-then-hibernate time is in `NIXOS/power-management.nix` while the time from idle->lock and lock->suspend-then-hibernate is found in `.config/awesome/power-management.nix`
### Keyring
The keyring is started in `.xprofile` to avoid running it as the user and needing a password.
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
* * *
 TODO:
 * Add lxappearance theming in configs
 * Use Home-Manager to handle these .config files
