#!/bin/bash

# This script is triggered when the pin configured as Volume Up in JCTL connector is shorted to GND.
# This script is launched once at startup.
# Feel free to hack it to implement your own functionality.
# Otherwise, it will switch the USB mode to Device.
#
#         MPU POWER   o  o  1V8
#
#         MPU RESET   o  ■  GND
#                        |
#                RX   o  o  VOLUME UP
#
#                TX   o  o  VOLUME DOWN
#
#          USB BOOT   o  ■  GND

echo "device" > /sys/kernel/debug/usb/4e00000.usb/mode
