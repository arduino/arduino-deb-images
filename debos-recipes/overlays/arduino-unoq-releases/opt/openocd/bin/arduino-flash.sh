#!/bin/bash

INSTALL_PATH=$(dirname "$(readlink -f $0)")/..

if [ $# -eq 2 ] ; then
	ZEPHYR=$1
	SKETCH=$2
elif [ $# -eq 1 ] ; then
	SKETCH=$1
else
	echo "Usage: $0 [zephyr.elf] sketch.elf-zsk.bin"
	exit 1
fi

CMDS="reset_config srst_only srst_push_pull; init; reset; halt; flash info 0"
if [ -z "$ZEPHYR" ] ; then
	echo
	echo WARNING: Only flashing the sketch, not the Zephyr core
	echo
else
	CMDS+="; flash write_image erase $ZEPHYR"
fi
CMDS+="; flash write_image erase $SKETCH 0x80F0000 bin; reset; shutdown"

$INSTALL_PATH/bin/openocd -d2 -s ${INSTALL_PATH} -f openocd_gpiod.cfg -c "$CMDS"
