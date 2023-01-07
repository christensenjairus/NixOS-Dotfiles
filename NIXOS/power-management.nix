# In systemd.sleep, there are some settings you should know:
    # States are as follows:
        #  'freeze' (Suspend-to-Idle)
        #  'standby' (Power-On Suspend)
        #  'mem' (Suspend-to-RAM)
        #  'disk' (Suspend-to-Disk)
    # Modes are as follows:
        #  'platform' (put the system into sleep using a platform-provided method)
        #  'shutdown' (shut the system down)
        #  'reboot' (reboot the system)
        #  'suspend' (trigger a Suspend-to-RAM transition)
        #  'test_resume' (resume-after-hibernation test mode)

{ config, pkgs, ... }:
let
  minsFromIdleUntilLock = 1;
  minsFromIdleUntilSuspend = "2";
  minsFromSuspendUntilHibernate = "20"; # enough to get between classes

in {
    # This can all be done by running this on boot:
    # `xset s ${timeFromIdleUntilLock} ${timeFromIdleUntilLock}; xss-lock -n 'i3lock-fancy-rapid 1 20' -- systemctl suspend-then-hibernate"`
        #services.xserver.xautolock = {
        # enable = true;
        #  locker = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 1 40";
        #  # nowlocker = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 1 40";
        #  time = minsFromIdleUntilLock;
        #  # killer = "/run/current-system/systemd/bin/systemctl suspend-then-hibernate";
        #  # killtime = minsFromIdleUntilSuspend; # Suspend after 10 mins
        #  extraOptions = [
        #    "-lockaftersleep" # ensure the screen is locked after sleeping
        #    "-detectsleep"
        #  ];
        #};
        #programs.xss-lock = {
        #  enable = true;
        #  # To perform suspend instead of lock
        #  lockerCommand = "/run/current-system/systemd/bin/systemctl suspend-then-hibernate";
        #  # To perform lock instead of notify
        #  extraOptions = ["-n ${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 1 40"];
        #};

    systemd.targets.sleep.enable = true;
    systemd.targets.suspend.enable = true;
    systemd.targets.hibernate.enable = true;
    systemd.targets.hybrid-sleep.enable = true;

    # Logind (see 'nix-option services.logind')
    services.logind = {
      lidSwitch="suspend-then-hibernate";
      lidSwitchDocked="ignore";
      lidSwitchExternalPower="ignore";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        # Without a desktop env, the idle time isn't communicated to systemd so these won't work
        # IdleAction=suspend-then-hibernate
        # IdleActionSec=${minsFromIdleUntilSuspend}m
        # StopIdleSessionSec=1m
      '';
    };

    # Sleep (see 'nix-option systemd.sleep.extraConfig')
    systemd.sleep.extraConfig = "HibernateDelaySec=${minsFromSuspendUntilHibernate}min";

    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
}