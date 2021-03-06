#!/bin/sh

# Suspend, hibernate, restart or shutdown the computer without sudo!
# by Chris Wong
# Released to the public domain.

NAME=$0

usage() {
    echo "Usage: $NAME suspend|hibernate|restart|shutdown"
}

if [ $# -ne 1 ] ; then
    usage
    exit 42
else
    THINGY_UPOWER="dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower"
    THINGY_CONSOLEKIT="dbus-send --system --print-reply --dest=org.freedesktop.ConsoleKit /org/freedesktop/ConsoleKit/Manager"
    case $1 in
        suspend)
            $THINGY_UPOWER org.freedesktop.UPower.Suspend
        ;;
        hibernate)
            $THINGY_UPOWER org.freedesktop.UPower.Hibernate
        ;;
        restart|reboot)
            $THINGY_CONSOLEKIT org.freedesktop.ConsoleKit.Manager.Restart
        ;;
        shutdown|halt)
            $THINGY_CONSOLEKIT org.freedesktop.ConsoleKit.Manager.Stop
        ;;
        usage)
            usage
            exit 0
        ;;
       *)
            usage
            exit 42
        ;;
    esac
fi
