local awful = require("awful") --Everything related to window managment

-- Important programs to start first
awful.spawn.with_shell("killall conky; conky -c $HOME/.config/conky/awesome/" .. "parrot" .. "-01.conkyrc")
awful.spawn.with_shell("/nix/store/i02lziq04y5j8wkkckzp608aqbr29bcs-kdeconnect-kde-22.08.3/libexec/kdeconnectd") -- This isn't running on boot, not sure why
awful.spawn.with_shell("picom")

-- awful.spawn.with_shell(soundplayer .. startupSound)
-- awful.spawn.with_shell("lxsession &")
-- awful.spawn.with_shell("gnome-keyring") -- needs to be started in .xprofile

-- AppIndicator Programs
--awful.spawn.with_shell("xfce4-power-manager &") -- also placed in .xprofile
awful.spawn.with_shell("sleep 2; nm-applet")
awful.spawn.with_shell("sleep 2; blueman-applet") -- takes a while, might as well be 3 seconds
awful.spawn.with_shell("killall volumeicon; sleep 5; volumeicon")
awful.spawn.with_shell("sleep 6; kdeconnect-indicator")
awful.spawn.with_shell("sleep 7; nextcloud --background")
awful.spawn.with_shell("sleep 8; flameshot")
awful.spawn.with_shell("sleep 9; bitwarden")
awful.spawn.with_shell("sleep 10; discord")
awful.spawn.with_shell("sleep 10; teams")
awful.spawn.with_shell("sleep 22; slack") -- open this last to be main screen on chat workspace

-- Non-AppIndicator Programs
-- awful.spawn.with_shell("/usr/bin/emacs --daemon")
awful.spawn.with_shell("sleep 1.8; terminator -r sys", { -- must wait so race condition is not created because the roles/tags don't exist immediately
    tag = 8, -- open in tag 8, in case this opens. For some reason, this doesn't run properly the first time
})
-- awful.spawn.with_shell("sleep 1.9; terminator -r sys", { -- must wait so race condition is not created because the roles/tags don't exist immediately
--     tag = 8, -- open in tag 8, in case this opens. For some reason, this doesn't run properly the first time
-- })
awful.spawn.with_shell("sleep 2 && terminator -e 'lf && zsh || zsh'")
awful.spawn.with_shell("sleep 2.2 && terminator -e 'neofetch | lolcat && zsh || zsh'")
awful.spawn.with_shell("sleep 2.4 && terminator -e 'bpytop && zsh || zsh'") -- largest window
-- awful.spawn("sleep 4; terminator -e 'pianobar && zsh || zsh' -r pianobar", {
--     tag = 6, -- not sure which of these settings works, but it does.
--     role = "pianobar",
-- })
--awful.spawn.with_shell("terminator -e 'pianobar && zsh || zsh'")
awful.spawn.with_shell("fusuma")
-- awful.spawn.with_shell("kdeconnect-sms")
awful.spawn.single_instance("firefox", {})
awful.spawn.with_shell("kill `pidof thunar`; thunar")
awful.spawn.single_instance("joplin-desktop", {})
--awful.spawn.with_shell("killall .spotify-wrapped; spotify")
--awful.spawn.with_shell("code /home/line6/.config/awesome/")
--awful.spawn.with_shell("code /home/line6/NIXOS/")
awful.spawn.with_shell("code /home/line6/dotfiles")

-- Wallpaper
--awful.spawn.with_shell("xargs xwallpaper --stretch < ~/.cache/wall")
--awful.spawn.with_shell("~/.fehbg") -- set last saved feh wallpaper
--awful.spawn.with_shell("feh --randomize --bg-fill /usr/share/backgrounds/dtos-backgrounds/*") -- feh sets random wallpaper
awful.spawn.with_shell("feh --bg-fill .wallpaper.jpg") -- feh sets specific wallpaper
-- awful.spawn.with_shell("nitrogen --restore") -- if you prefer nitrogen to feh/xwallpaper