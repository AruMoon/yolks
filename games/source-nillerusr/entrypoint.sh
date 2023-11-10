#!/bin/bash

# Give everything time to initialize for preventing SteamCMD deadlock
sleep 1

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

if [ -z ${AUTO_UPDATE} ] || [ "$AUTO_UPDATE" == "1" ]; then
    git clone https://github.com/nillerusr/source-engine.git src
    cd src
    git pull
    git submodule update --init --recursive
    ./waf install --strip
    ./waf configure -T release -d -4 --build-game=${SRCDS_GAME} --prefix=/home/container
    ./waf install --strip
    cd /home/container

    ln -s bin/libvstdlib.so bin/libvstdlib_srv.so
    ln -s bin/libtier0.so bin/libtier0_srv.so
else
    echo -e "Not updating game server as auto update was set to 0. Starting Server"
fi

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}
