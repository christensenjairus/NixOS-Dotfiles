local awful = require("awful") --Everything related to window managment

--Enable Energy Star Power Management (blank screen after some time, but not controlling lock or suspend)
awful.spawn.with_shell("xset +dpms")

--1st number is seconds from idle until lock
--2nd number is seconds from lock until suspend
awful.spawn.with_shell("xset s 300 900")
--Lock after 300s (5m), suspend after another 900s (15m)

--Lock screen & suspend commands and program to execute them
awful.spawn.with_shell("killall xss-lock; xss-lock -n 'i3lock-fancy-rapid 1 50' -- systemctl suspend-then-hibernate &")
