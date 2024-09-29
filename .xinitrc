#resolution-2k &
#fix-resolution &
xrandr --output HDMI-A-1 --mode 1920x1080 --rate 100 &
#setxkbmap es &
xsetroot -cursor_name left_ptr &
#redshift &
xwallpaper --zoom /home/vfred0/Images/Wallpapers/Statics/07.jpg
xrdb -merge ~/.Xresources &
status-bar &
/usr/bin/wireplumber &
easyeffects  --gapplication-service &
picom &
dunst &
flameshot &
#exec zwm
# live-wallpaper next &
while type dwm >/dev/null; do dwm && continue || break; done
