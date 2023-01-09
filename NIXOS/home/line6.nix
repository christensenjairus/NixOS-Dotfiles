{ config, pkgs, ... }:
let

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Themeing
  gtk.cursorTheme.package = "pkgs.capitaine-cursors";
  gtk.cursorTheme.name = "Capitaine Cursors";
  gtk.iconTheme.package = "pkgs.papirus-icon-theme";
  gtk.iconTheme.name = "Papirus-Dark";
  #gtk.theme = "Materia-Dark-Compact";
  gtk.theme.package = "pkgs.canta-theme";
  gtk.theme.name = "Canta";


  # Allow some insecure or EOL packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-12.2.3"
    "xrdp-0.9.9"
  ];

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "line6";
    homeDirectory = "/home/line6";

    packages = import ../packages/user-pkgs.nix pkgs;

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  };
}
