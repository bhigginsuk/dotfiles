## Background
/usr/bin/protonmail-bridge --no-window &
/usr/bin/unclutter &
/usr/bin/flameshot &
/usr/bin/workrave &
/usr/bin/xrandr --output DisplayPort-0 --mode 3440x1440 --rate 120 &
/usr/bin/redshift-gtk &
/usr/bin/xautolock -time 15 -locker slock &
/usr/bin/xautolock -time 30 -locker "systemctl suspend" &
/usr/bin/udiskie &
/usr/bin/dunst &
/usr/bin/qbittorrent &
/usr/bin/pasystray &
/opt/linux-amd64-etesync-dav & # Temporary measure while AUR version crashes on sync
/usr/bin/syncthing-gtk &
/usr/local/bin/dwmblocks &

# Workspace 1
/usr/local/bin/st -T cmus /usr/bin/cmus &
/usr/local/bin/st -T taskell /usr/local/bin/taskell &
sleep 0.1 && /usr/local/bin/st -T khal /usr/bin/ikhal &
sleep 0.5 && LD_LIBRARY_PATH=/opt/libyaml-0.2.4:$LD_LIBRARY_PATH /usr/local/bin/st -T sup sup /usr/bin/sup &

exec dwm
