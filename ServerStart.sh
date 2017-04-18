#!/bin/sh

# Fix work directory
# Some GUIs set wrong working directory which breaks relative paths
cd -- "$(dirname "$0")"

# Read pack related settings from external setting file
. ./settings-local.sh


# cleaner code 
start_server() {
    "$JAVACMD" -server -Xms${MIN_RAM} -Xmx${MAX_RAM} -XX:PermSize=${PERMGEN_SIZE} ${JAVA_PARAMETERS} -jar forge-1.10.2-12.18.3.2254-universal.jar nogui
}


echo "Starting server"
rm -f autostart.stamp
start_server

while [ -e autostart.stamp ] ; do
    rm -f autostart.stamp
    echo "If you want to completely stop the server process now, press Ctrl+C before the time is up!"
    for i in 5 4 3 2 1; do
        echo "Restarting server in $i"
        sleep 1
    done
    echo "Rebooting now!"
    start_server
    echo "Server process finished"
done