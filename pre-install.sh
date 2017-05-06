#!/bin/bash
echo "blacklist pcf8591
blacklist bmp085" >> /etc/modprobe.d/fbdev-blacklist.conf
reboot
