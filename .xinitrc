setxkbmap -layout us,bg -variant ,phonetic
xset r rate 180 18
stty -ixon
udiskie &
/usr/bin/start-pulseaudio-x11

[[ -f ~/.xbindkeysrc ]] && xbindkeys
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
