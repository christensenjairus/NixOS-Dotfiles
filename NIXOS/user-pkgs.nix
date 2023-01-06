pkgs: with pkgs; [
      # For AwesomeWM
      awesome
      rofi
      dmenu
      picom
      i3lock-fancy-rapid
      xclip
      polkit_gnome
      libsecret
      gnome.gnome-keyring
      libgnome-keyring
      gnome.seahorse
      materia-theme
      papirus-folders
      papirus-icon-theme
      # lxde.lxsession
      lxappearance
      flameshot
      pnmixer
      networkmanagerapplet
      wg-netmanager
      networkmanager-openconnect
      xfce.xfce4-power-manager
      volumeicon
      # xautolock
      # compton
      feh
      nitrogen
      variety
      arandr
      # blueberry
      fusuma
      conky
      xfce.thunar
      xss-lock
      libnotify
      #haskellPackages.dmenu
      #haskellPackages.dmenu-pkill
      #haskellPackages.dmenu-search
      #haskellPackages.dmenu-pmount
      #haskellPackages.yeganesh

      # Needed for ThinkPad
      xorg.xf86videointel
      # xorg.xbacklight
      acpilight # includes xbacklight (supercedes it, actually)
      brightnessctl

      # None AwesomeWM Pkgs
      firefox
      # alacritty
      # emacs
      electron
      neofetch
      # gnome-photos
      # tilix
      terminator
      unrar-wrapper
      lolcat
      inxi
      wireguard-tools
      vscode
      # gnome.nautilus
      lf
      # pcmanfm
      # nautilus-open-any-terminal
      dropbox
      joplin-desktop
      # onedrive # installed using configuration.nix
      google-chrome
      slack
      flameshot
      # gnome.gedit
      globalprotect-openconnect
      jetbrains.pycharm-professional
      jetbrains.clion
      jetbrains.goland
      jetbrains.idea-ultimate
      jetbrains.webstorm
      jetbrains.phpstorm
      jetbrains.gateway
      jetbrains.datagrip
      spotify
      # pithos can't get this working without Gnome. Pianobar is fine instead.
      pianobar
      wpsoffice
      vmware-workstation
      blueman
      zoom-us
      virtualbox
      remmina
      xterm # needs to be installed for many applications that open terminals.
      #zsh
      oh-my-zsh
      zsh-powerlevel10k
      fzf
      xdotool
      wmctrl
      # libinput
      # libinput-gestures # Using a fusuma for this in AwesomeWM.
      bluez
      bluez-tools
      system-config-printer # Might just be needed in Gnome?
      macchanger
      zerotierone
      openvpn
      # gitg
      github-desktop
      bitwarden
      clamav
      nextcloud-client
      bpytop
      calibre
      digikam
      deja-dup
      lutris
      lbry
      krita
      ardour
      audacity
      atom
      # ulauncher # Using dmenu and rofi instead. But this is prettier.
      etcher
      notepadqq
      darktable
      pdfsam-basic
      ffmpeg_5-full
      clinfo # might only be necessary for testing OpenCL graphics.
      tmux
      ocrmypdf
      teams
      emote
      discord
      gparted
      nodejs
      python3 # still can't figure out how to install python packages.
      poetry
      node2nix
      yarn2nix
      toml2nix
      # stack2nix # nix says this is temporarily broken
      setupcfg2nix
      #python3Packages.pip # Not sure I can even use this in NixOS
      #python2Full
      # touchegg
      dolphin-emu
      cemu
      retroarchFull
      qt6.full
      gnumake
      canta-theme
      neovim
      vimix-icon-theme
      oceanic-theme
      material-icons
      gnome.gnome-tweaks
      gnome.gnome-system-monitor
      #gnomeExtensions.x11-gestures
      #gnomeExtensions.gesture-improvements
      #gnomeExtensions.desktop-icons-ng-ding
      #gnomeExtensions.appindicator
      #gnomeExtensions.arcmenu
      #gnomeExtensions.bluetooth-quick-connect
      #gnomeExtensions.clipboard-indicator
      #gnomeExtensions.dash-to-dock
      #gnomeExtensions.gsconnect
      #gnomeExtensions.gtk-title-bar
      #gnomeExtensions.unblank
      #gnomeExtensions.unlock-dialog-background
      #gnomeExtensions.removable-drive-menu
      #gnomeExtensions.sound-output-device-chooser
      #gnomeExtensions.task-widget
      #gnomeExtensions.notification-timeout
      #gnomeExtensions.transparent-top-bar
      #gnomeExtensions.user-themes
      #gnomeExtensions.window-is-ready-remover
      #gnomeExtensions.windownavigator
      #gnomeExtensions.wireguard-indicator

      ### Penetration Testing ###
      ### General utils ###
      # bat
      ranger # file explorer, lf is an edited version of this

      ### Exploitation ###
      metasploit
      # sqlmap

      ### Forensics ###
      # capstone
      # ddrescue
      # ext4magic
      # extundelete
      ghidra-bin
      git
      # p0f
      # pdf-parser
      python310Packages.binwalk
      python310Packages.distorm3
      # sleuthkit
      # volatility

      ### Hardware ###
      # apktool

      ### Recon ###
      # cloudbrute
      dnsenum
      dnsrecon
      enum4linux
      # hping
      masscan
      netcat
      nmap
      # ntopng
      # sn0int
      # sslsplit
      theharvester
      wireshark
      # wireshark-cli # should include wireshark

      ### Backdoors ###
      # httptunnel
      # pwnat

      ### Passwords ###
      # brutespray
      # chntpw
      # crowbar
      # crunch
      hashcat
      # hcxtools
      john
      # python36Packages.patator
      # phrasendrescher
      thc-hydra

      ### Reverse ###
      # binutils
      # elfutils
      # jd
      # jd-gui
      # patchelf
      # radare2
      # radare2-cutter
      # retdec
      # snowman
      valgrind
      # yara

      ### Sniffing ###
      # bettercap
      # dsniff
      # mitmproxy
      # rshijack
      # sipp
      # sniffglue

      ### Vuln analisys ###
      # grype
      # lynis
      # sqlmap # In exploitation section
      # vulnix

      ### Web ###
      burpsuite
      dirb
      gobuster
      # urlhunter
      # wfuzz
      # wpscan
      # zap
]
