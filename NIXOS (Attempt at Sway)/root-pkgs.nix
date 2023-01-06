pkgs: with pkgs; [
    # Sway packages
      alacritty # gpu accelerated terminal
      sway
      dbus-sway-environment
      configure-gtk
      wayland
      xdg-utils # for openning default programms when clicking links
      glib # gsettings
      dracula-theme # gtk theme
      gnome3.adwaita-icon-theme  # default gnome cursors
      swaylock
      swayidle
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      bemenu # wayland clone of dmenu
      mako # notification system developed by swaywm maintainer


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
]
