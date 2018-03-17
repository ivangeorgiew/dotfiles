xset r rate 180 18
stty intr \^b
/usr/bin/start-pulseaudio-x11

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3
