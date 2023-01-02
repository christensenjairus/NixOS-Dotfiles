pkgs: with pkgs; [
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
