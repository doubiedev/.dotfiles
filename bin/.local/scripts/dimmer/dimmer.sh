if [ "$1" = 10 ]; then
  percent="1"
else
  percent="0.$1"
fi

xrandr --output eDP-1 --brightness "$percent"
