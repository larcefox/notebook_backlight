# notebook_backlight
Auto adjust notebook backlight with webcamera and xbacklight.
Requirements:
1. fswebcam
2. imagemagick (conver)
3. sed
4. xbacklight

Algorithm took picture from webcam, convert it to 1x1 pixel image and use its brightness to set backlight of notebook screen.
