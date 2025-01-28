# xrandr-brightness-script
Utility script for adjusting the brightness and color temperatures of displays using xrandr.

Especially useful for OLED screens that don't have adjustable hardware backlights.

I recommend binding this script to custom keyboard shortcuts for easy accessibility.

## Usage:

You can run `brightness.sh` to get a usage description and identify connected displays.

```
$ ./brightness.sh
Usage: brightness.sh op display [stepsize|value] [--temp]

arguments:
  op:             - to decrease or + to increase brightness
                  = to set brightness to a specific value
  display:        name of a connected display to adjust
  stepsize:       size of adjustment step (default 0.1)
  value:          value to set (default 1.0 for brightness, 0.6 for color temperature)
  --temp:         adjusts color temperature instead of brightness

displays:
  eDP1     brightness:  1.0  gamma:  1.0:1.0:1.0  temp:  0.6
  DVI-D-0  brightness:  1.0  gamma:  1.0:1.0:1.0  temp:  0.6
  HDMI-0   brightness:  1.0  gamma:  1.0:1.0:1.0  temp:  0.6
```

**Note**: Color temperatures range from 0.0 (*warm*) to 1.0 (*cold*) and represent Kelvin values between 3000K and 10000K

### Examples:

```
$ ./brightness.sh + eDP1               Increase brightness of eDP1 display by 0.1
$ ./brightness.sh - eDP1               Decrease brightness of eDP1 display by 0.1

$ ./brightness.sh + eDP1 --temp        Increase color temperature of eDP1 display by 0.1
$ ./brightness.sh - eDP1 --temp        Decrease color temperature of eDP1 display by 0.1

$ ./brightness.sh + eDP1 0.2           Increase brightness of eDP1 display by 0.2
$ ./brightness.sh - eDP1 0.2           Decrease brightness of eDP1 display by 0.2

$ ./brightness.sh + eDP1 0.2 --temp    Increase color temperature of eDP1 display by 0.2
$ ./brightness.sh - eDP1 0.2 --temp    Decrease color temperature of eDP1 display by 0.2

$ ./brightness.sh = eDP1               Reset brightness of eDP1 display to 1.0
$ ./brightness.sh = eDP1 0.5           Set brightness of eDP1 display to 0.5

$ ./brightness.sh = eDP1 --temp        Reset color temperature of eDP1 display to 0.6
$ ./brightness.sh = eDP1 0.4 --temp    Set color temperature of eDP1 display to 0.4
```
## Motivation:

My motivation for creating this little script was a problem my friend was having with his new HP Spectre x360 OLED using Linux.
He wasn't able to adjust the display brightness via the designated brightness keys on his keyboard. 
So I wrote this script for him and thought maybe others with similar problems could profit from me publishing this.
