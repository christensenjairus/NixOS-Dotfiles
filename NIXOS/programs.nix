{ config, pkgs, lib, ... }:
let

in {
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
          alias update="pushd ~/ && sudo nix flake update -I ~/dotfiles/NIXOS/# && popd"
          alias rebuildsystem="pushd ~/ && sudo nixos-rebuild switch --flake ./dotfiles/NIXOS/# --impure && popd"
          alias rebuildhome="pushd ~/ && sudo nix build ./dotfiles/NIXOS/#homeManagerConfigurations.line6.activationPackage && sudo ./result/activate && sudo rm -r ./result && popd"
          alias clean="sudo nix-env --delete-generations old && sudo nix-store --gc && sudo nix-collect-garbage -d"
          alias n="nvim"
        '';
        promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"; # sets theme
      };
      dconf.enable = true;
    };
    environment.shells = [ pkgs.zsh ];
}