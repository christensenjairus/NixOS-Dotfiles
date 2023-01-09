{ config, pkgs, lib, ... }:
let
username = "line6";
displayname = "Jairus Christensen";
pubsshkey1 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDjxV/ZxnvuNnSaMzzKCXc5cDtpVqLfwod0SKHkYcriaAZmrJwfCpWUKIDD5Www0YFWllucHZoTGDovCx4RwOhimDC0kMHvSNrXz2CJpeheN1gvSods6oWO2Y4Qat/8UVSsL8TaOenX6GbsKP7Vvbw8a+ROxs6E6S9MZeGNKQ3P8cD5goV3RgVZfmcqqwXqc2NwMaJkguZMqxNgC5IYuGudaYI5dqPOV7AqiyW1eRVh48z7Ce75vPwiBJQF5jrv6DvMNiL69hletHzEUnBUmiuAkBwEXHqzxbOQVRwZNOxj7+CejaJr4NA+d+Y0daRP9LO1rYz66bVPW0wc1/feEWROipDLOnoIGbKwhgP8PulYDd4KEKOoyrc8HjqbQDNLSQRnw5cMYLhTXMfci2oAJaUjv2ler1JAi4M8vK9PYMf6U6FmX5GiKmuCf51IM+NJH471tzhlmqSNKJ7brij4ppFMYEgpPWeK2n2yBajNHDLSgj9Qxv08vLaJpNxSRCY3QoM= jairus christensen@Zeus-Win11Pro";

in
{
  # Make ready for Nix Flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Kernel (latest)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # AutoUpgrade
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Garbage Collection (4am every day)
  nix.gc.automatic = true;
  nix.gc.dates = "04:00";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${displayname}";
    extraGroups = [ "networkmanager" "wheel" "input" "video" "docker" ];
    # packages = import ./packages/user-pkgs.nix pkgs;
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
  environment.systemPackages = import ./packages/root-pkgs.nix pkgs;

  # Add fonts
  fonts.fonts = with pkgs; [
    nerdfonts
    iosevka
    jetbrains-mono
    meslo-lgs-nf
    roboto
    symbola
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "colemak_dh";
    xkbOptions = "caps:backspace,grp:alt_shift_toggle";
  };
  console.useXkbConfig = true; # Use keyboard config outside X11

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
  system.stateVersion = "23.05";
}