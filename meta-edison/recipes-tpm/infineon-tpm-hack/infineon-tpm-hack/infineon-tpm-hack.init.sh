#!/bin/sh

### BEGIN INIT INFO
# Provides:		infineon tpm hack
# Required-Start:
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start:	1 2 3 4 5
# Default-Stop:		0 6
# Short-Description:    hack to get infineon i2c tpm to work on the edison
# Description:		associate infineon i2c tpm driver with non-standard address
### END INIT INFO

BUS=1
ADDRESS=0x30
DRIVER=tpm_i2c_infineon
BUS_DIR=/sys/bus/i2c/devices/i2c-${BUS}
NEW_DEV=${BUS_DIR}/new_device
DEL_DEV=${BUS_DIR}/delete_device

DESC="Infineon I2C TPM hack for Edison"

case "${1}" in
	start)
		echo "Loading $DESC: "

        if test ! -e ${NEW_DEV}; then
			echo "Can't find I2C bus: ${BUS}, skipping."
			exit 0
		fi

        echo ${DRIVER} ${ADDRESS} > ${NEW_DEV} && echo "success"
		exit $?
		;;

	stop)
		echo "Unloading $DESC: "

        if test ! -e ${DEL_DEV}; then
            echo "Can't find I2C bus: ${BUS}, skipping."
            exit 0
        fi
        echo ${ADDRESS} > ${DEL_DEV} && echo "success"
		exit $?
		;;
	*)
		echo "Usage: ${NAME} {start|stop}" >&2
		exit 3
		;;
esac

exit 0
