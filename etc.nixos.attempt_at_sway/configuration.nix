# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

# Let/In definition only necessary for Sway
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Kernel
  # boot.kernelPackages = pkgs.linuxPackages_5_15;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # AMD GPU
  # boot.initrd.kernelModules = [ "amdgpu" ];
  # services.xserver.videoDrivers = [ "amdgpu" ];

  networking.hostName = "Ares-NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Sway Window Manager
  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Enable the X11 windowing system.
  #services.xserver = {
  #  enable = true;
  #  xautolock.enable = true;
  #
  #  # Display Manager
  #  displayManager = {
  #    lightdm.enable = true;
  #    # gdm.enable = true; # Does not honor colemak shortcuts
  #    defaultSession = "none+awesome";
  #    # displayManager.gdm.wayland = false; # Use X11
  #    # displayManager.gdm.wayland = true; # Use Wayland
  #  };
  #
  #  # Desktop Environment.
  #  # desktopManager.gnome.enable = true; No Desktop Manager
  #
  #  windowManager.awesome = {
  #    enable = true;
  #    luaModules = with pkgs.luaPackages; [
  #      luarocks # is the package manager for Lua modules
  #      luadbi-mysql # Database abstraction layer
  #    ];
  #  };
  #
  #  # synaptics.enable = true; # touchpad driver
  #  libinput = {
  #    enable = true;
  #    touchpad.middleEmulation = true;
  #    touchpad.tapping = true;
  #    touchpad.naturalScrolling = true;
  #  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # Enable RDP
  services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "gnome-session";
  # networking.firewall.allowedTCPPorts = [ 3389 ]; # Placed this at end of file instead

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  # ssh.startAgent = true;

  # Enable OneDrive
  services.onedrive.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak_dh";
    xkbOptions = "caps:backspace";
  };
  console.useXkbConfig = true; # Use keyboard config outside X11

#  services.interception-tools =
#    let
#      dfkConfig = pkgs.writeText "dual-function-keys.yaml" ''
#        MAPPINGS:
#          - KEY: KEY_CAPSLOCK
#            TAP: KEY_ESC
#            HOLD: KEY_LEFTCTRL
#      '';
#    in
#    {
#      enable = true;
#      plugins = lib.mkForce [
#        pkgs.interception-tools-plugins.dual-function-keys
#      ];
#      udevmonConfig = ''
#        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c ${dfkConfig} | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
#          DEVICE:
#            # NAME: "USB Keyboard"
#           NAME: "Virtual core XTEST keyboard" # use 'xinput' to find this
#            EVENTS:
#              EV_KEY: [[KEY_CAPSLOCK, KEY_ESC, KEY_LEFTCTRL]]
#      '';
#    };


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Allow some insecure or EOL packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
  ];

  # ZRAM (Use on VMs)
  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;

  # Swapfile (Use on Bare Metal)
  swapDevices = [ { device = "/var/swapfile"; size = 16384; } ];
  boot.resumeDevice = "/dev/nvme0n1p4";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.line6 = {
    isNormalUser = true;
    description = "Jairus Christensen";
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
    packages = import ./user-pkgs.nix pkgs;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add fonts
  fonts.fonts = with pkgs; [
    nerdfonts
    iosevka
    jetbrains-mono
    meslo-lgs-nf
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Sway packages
      alacritty # gpu accelerated terminal
      sway
      swaybg
      swaylock
      swayidle
      wlroots
      wl-clipboard
      waybar
      wofi
      kanshi
      foot
      mako
      grim
      slurp
      wf-recorder
      light
      yad
      wlogout
      xfce.thunar
      geany
      mpv
      mpg321
      mpc123
      mpd
      viewnior
      imagemagick
      arc-theme
      zafiro-icons
      qogir-theme
      # xfce-polkit - going to use the gnome one instead
      # xorg-wayland - assuming 'wayland' is the same as 'xorg-wayland'
      dbus-sway-environment
      configure-gtk
      wayland
      xdg-utils # for openning default programms when clicking links
      glib # gsettings
      dracula-theme # gtk theme
      gnome3.adwaita-icon-theme  # default gnome cursors
      #grim # screenshot functionality
      #slurp # screenshot functionality
      #wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      bemenu # wayland clone of dmenu
      #mako # notification system developed by swaywm maintainer


    #gnome.gnome-session # Allows RDP to work
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    curl
    git
    #plocate
    killall
    # nginx # Using service for this instead
    # apacheHttpd
  ];

  # Enable Nginx
  # services.nginx.enable = true;
  # Enable Apache

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.kdeconnect.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # programs.ssh.hostKeyAlgorithms = [ "+ssh-rsa" ]; # Thought this might fix Guacamole SSH; it doesn't.
  users.users.line6.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjxV/ZxnvuNnSaMzzKCXc5cDtpVqLfwod0SKHkYcriaAZmrJwfCpWUKIDD5Www0YFWllucHZoTGDovCx4RwOhimDC0kMHvSNrXz2CJpeheN1gvSods6oWO2Y4Qat/8UVSsL8TaOenX6GbsKP7Vvbw8a+ROxs6E6S9MZeGNKQ3P8cD5goV3RgVZfmcqqwXqc2NwMaJkguZMqxNgC5IYuGudaYI5dqPOV7AqiyW1eRVh48z7Ce75vPwiBJQF5jrv6DvMNiL69hletHzEUnBUmiuAkBwEXHqzxbOQVRwZNOxj7+CejaJr4NA+d+Y0daRP9LO1rYz66bVPW0wc1/feEWROipDLOnoIGbKwhgP8PulYDd4KEKOoyrc8HjqbQDNLSQRnw5cMYLhTXMfci2oAJaUjv2ler1JAi4M8vK9PYMf6U6FmX5GiKmuCf51IM+NJH471tzhlmqSNKJ7brij4ppFMYEgpPWeK2n2yBajNHDLSgj9Qxv08vLaJpNxSRCY3QoM= jairus christensen@Zeus-Win11Pro" ];

  # Do not sleep
  # systemd.targets.sleep.enable = false;
  # systemd.targets.suspend.enable = false;
  # systemd.targets.hibernate.enable = false;
  # systemd.targets.hybrid-sleep.enable = false;
  # services.xserver.displayManager.gdm.autoSuspend = false;
  # services.xserver.xautolock.time = 0;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 3389 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764;} # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
