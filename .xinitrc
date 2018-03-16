exec i3
xset r rate 180 18
/usr/bin/start-pulseaudio-x11

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
