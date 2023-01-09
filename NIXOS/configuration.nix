# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
username = "line6";
displayname = "Jairus Christensen";
pubsshkey1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjxV/ZxnvuNnSaMzzKCXc5cDtpVqLfwod0SKHkYcriaAZmrJwfCpWUKIDD5Www0YFWllucHZoTGDovCx4RwOhimDC0kMHvSNrXz2CJpeheN1gvSods6oWO2Y4Qat/8UVSsL8TaOenX6GbsKP7Vvbw8a+ROxs6E6S9MZeGNKQ3P8cD5goV3RgVZfmcqqwXqc2NwMaJkguZMqxNgC5IYuGudaYI5dqPOV7AqiyW1eRVh48z7Ce75vPwiBJQF5jrv6DvMNiL69hletHzEUnBUmiuAkBwEXHqzxbOQVRwZNOxj7+CejaJr4NA+d+Y0daRP9LO1rYz66bVPW0wc1/feEWROipDLOnoIGbKwhgP8PulYDd4KEKOoyrc8HjqbQDNLSQRnw5cMYLhTXMfci2oAJaUjv2ler1JAi4M8vK9PYMf6U6FmX5GiKmuCf51IM+NJH471tzhlmqSNKJ7brij4ppFMYEgpPWeK2n2yBajNHDLSgj9Qxv08vLaJpNxSRCY3QoM= jairus christensen@Zeus-Win11Pro";

in
{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix # Included as a flake module instead
      ./power-management.nix
    ];

  # Make ready for Nix Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Kernel (latest)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # channel
  #channel = "https://nixos.org/channels/nixos-unstable";

  # AutoUpgrade
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Garbage Collection (4am every day)
  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

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

  # GNOME DEFAULTS START #
      # Enable the X11 windowing system.
      # services.xserver.enable = true;

      # Enable the GNOME Desktop Environment.
      # services.xserver.displayManager.gdm.enable = true; # Does not honor colemak shortcuts
      # services.xserver.desktopManager.gnome.enable = true;
  # GNOME DEFAULTS END #

  # AWESOMEWM CONFIG INSTEAD (START) #
      # Enable the X11 windowing system.
      services.xserver = {
        enable = true;

        # Display Manager
        displayManager = {
          lightdm = {
            enable = true;
            greeters.enso = {
              enable = true;
              blur = true;
              #user = username;
            };
            background = "${/home/line6/.wallpaper.jpg}";
            #extraConfig = ''
            #  #[User]
            #  Icon= "${/home/line6/.face}" # This does not work here or in the greeters.
            #'';
          };
          defaultSession = "none+awesome";
        };

        windowManager.awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
            luadbi-mysql # Database abstraction layer
          ];
        };

        # synaptics.enable = true; # touchpad driver
        libinput = {
          enable = true;
          touchpad.middleEmulation = true;
          touchpad.tapping = true;
          touchpad.naturalScrolling = true;
        };
      };

      #programs.xss-lock = {
      #  enable = true;
      #  lockerCommand = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 1 20";
      #  extraOptions = [
      #    "--session $XDG_SESSION_ID"
      #  ];
      #};
  # AWESOME CONFIG INSTEAD (END) #

  # SWAP OPTIONS (if not in hardware-configuration.nix)
    # ZRAM (Use on VMs)
      # zramSwap.enable = true;
      # zramSwap.memoryPercent = 50;
    # Swapfile (Use on Bare Metal)
      # swapDevices = [ { device = "/var/swapfile"; size = 18022; } ]; # 1.1 times the RAM.
      # boot.resumeDevice = "/dev/disk/by-uuid/7aaf0ec8-c230-44e4-8ed2-f4e78e2e6a4a";
      # boot.kernelParams = [ "resume_offset=32194560" ]; # find using filefrag -v /var/swapfile and its the first physical offset listed. Changes every time file is remade.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${displayname}";
    extraGroups = [ "networkmanager" "wheel" "input" "video" "docker" ];
    packages = import ./user-pkgs.nix pkgs;
    openssh.authorizedKeys.keys = [ "${pubsshkey1}" ];
  };

  # Allow some insecure or EOL packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "xrdp-0.9.9"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = import ./root-pkgs.nix pkgs;

  # Add fonts
  fonts.fonts = with pkgs; [
    nerdfonts
    iosevka
    jetbrains-mono
    meslo-lgs-nf
    roboto
    symbola
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.kdeconnect.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services that you want to enable:
    # Enable Nginx
    # services.nginx.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    services.openssh.enable = true;
    # programs.ssh.hostKeyAlgorithms = [ "+ssh-rsa" ]; # Thought this might fix Guacamole SSH; it doesn't.

    # Enable Bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable RDP
    services.xrdp.enable = true;
    # services.xrdp.defaultWindowManager = "gnome-session";

    # Keyring
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.lightdm.enableGnomeKeyring = true;
    # ssh.startAgent = true;

    # Enable OneDrive
    services.onedrive.enable = true;

    # Enable SMB in FileBrowsers like Thunar, Nautilus, etc.
    services.gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gnome3.gvfs;
    };

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

    # Turn on postgresql (mainly for msfconsole)
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      enableTCPIP = true;
      ensureDatabases = [
        "msf"
      ]; # Once in metasploit, run `db_connect --name msf msf<:optional_pw>@localhost/msf` on first use and `db_connect msf` after that.
         # Running `db_save` after you're connected will prevent needing to log in the future.
      ensureUsers = [
        {
          name = "msf";
          ensurePermissions = {
            "DATABASE msf" = "ALL PRIVILEGES";
          };
        }
      ];
      authentication = lib.mkForce ''
        # Generated file; do not edit!
        # TYPE  DATABASE        USER            ADDRESS                 METHOD
        local   all             all                                     trust
        host    all             all             127.0.0.1/32            trust
        host    all             all             ::1/128                 trust
      '';
      # Startup script assigns the database to MSF allowing msfconsole to work.
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE msf WITH LOGIN PASSWORD 'msf' CREATEDB;
        CREATE DATABASE msf;
        ALTER DATABASE msf OWNER TO msf;
        GRANT ALL PRIVILEGES ON DATABASE msf TO msf;
      '';
    };

    #services.interception-tools =
    #  let
    #    dfkConfig = pkgs.writeText "dual-function-keys.yaml" ''
    #      MAPPINGS:
    #        - KEY: KEY_CAPSLOCK
    #          TAP: KEY_ESC
    #          HOLD: KEY_LEFTCTRL
    #    '';
    #  in
    #  {
    #    enable = true;
    #    plugins = lib.mkForce [
    #      pkgs.interception-tools-plugins.dual-function-keys
    #    ];
    #    udevmonConfig = ''
    #      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c ${dfkConfig} | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
    #        DEVICE:
    #          # NAME: "USB Keyboard"
    #         NAME: "Virtual core XTEST keyboard" # use 'xinput' to find this
    #          EVENTS:
    #            EV_KEY: [[KEY_CAPSLOCK, KEY_ESC, KEY_LEFTCTRL]]
    #    '';
    #  };

  # Program Configurations
    programs = {
      zsh = {
        enable = true;
        autosuggestions.enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableGlobalCompInit = true;
        syntaxHighlighting.enable = true;
        interactiveShellInit = ''
          # THIS IS BASICALLY THE .zshrc FILE. Runs on launch
          export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
          export FZF_BASE=${pkgs.fzf}/share/fzf/

          ZSH_THEME="robbyrussell" # this will be changed to powerlevel10k upon init
          plugins=(git fzf)

          HISTFILESIZE=500000
          HISTSIZE=500000

          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
          source $ZSH/oh-my-zsh.sh

          # Jairus' Commands
          alias update="sudo nix-channel --update"
          alias rebuild="sudo cp /home/line6/NIXOS/* /etc/nixos/ && sudo nixos-rebuild switch"
          alias clean="sudo nix-env --delete-generations old && sudo nix-store --gc && sudo nix-collect-garbage -d"
          alias n="nvim"
        '';
        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; # sets theme
      };
    };
    environment.shells = [ pkgs.zsh ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak_dh";
    xkbOptions = "caps:backspace,grp:alt_shift_toggle";
  };
  console.useXkbConfig = true; # Use keyboard config outside X11

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 3389 5432 ];
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
