{ config, pkgs, lib, ... }:
let

in {
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
}