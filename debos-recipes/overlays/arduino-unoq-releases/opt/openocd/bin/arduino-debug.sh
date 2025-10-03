#!/bin/bash

INSTALL_PATH=$(dirname "$(readlink -f $0)")/..
CMDS="reset_config srst_only srst_push_pull; init"

$INSTALL_PATH/bin/openocd -d2 -s ${INSTALL_PATH} -f openocd_gpiod.cfg -c "$CMDS"
