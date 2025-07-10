. /useremain/rinkhals/.current/tools.sh

APP_ROOT=$(dirname $(realpath $0))
export ANYCUBIC_S1_IP="IP_ANYCUBIC_S1"
export HA_BROKER="MQTT_BROKER_IP"
export HA_PORT="1883_OR_OTHER_MQTT_PORT"
export HA_USER="MQTT_LOGIN"
export HA_PASS="MQTT_PASSWORD"
export SNAPSHOT_INTERVAL_IDLE=60
export SNAPSHOT_INTERVAL_BUSY=30
export INFO_UPDATE_INTERVAL=10

status() {
    PID=$(get_by_name asm.py)

    if [ "$PID" == "" ]; then
        report_status $APP_STATUS_STOPPED
    else
        report_status $APP_STATUS_STARTED "$PID"
    fi
}
start() {
    stop
    
    cd $APP_ROOT
    python ./asm.py &
}
stop() {
    kill_by_name asm.py
}

case "$1" in
    status)
        status
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: $0 {status|start|stop}" >&2
        exit 1
        ;;
esac
