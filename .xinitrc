xrandr --output HDMI-A-1 --mode 1920x1080 --rate 100 &
xsetroot -cursor_name left_ptr &
xwallpaper --zoom /home/vfred0/Images/Wallpapers/Statics/07.jpg
xrdb -merge ~/.Xresources &
status-bar &
/usr/bin/wireplumber &
easyeffects  --gapplication-service &
picom &
dunst &
flameshot &
while type dwm >/dev/null; do dwm && continue || break; done
