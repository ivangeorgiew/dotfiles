setxkbmap -layout us,bg -variant ,phonetic -option grp:alt_shift_toggle
xset r rate 180 18
udiskie &
/usr/bin/start-pulseaudio-x11

[[ -f ~/.xbindkeysrc ]] && xbindkeys
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3
