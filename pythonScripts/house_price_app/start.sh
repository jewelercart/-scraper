#!/bin/bash

# Path to your virtual environment
VENV_PATH="/home/housecashprohome/pythonScripts/house_price_app/venv"

# Path to your app
APP_PATH="/home/housecashprohome/pythonScripts/house_price_app"

# Gunicorn bind address and app module
BIND="0.0.0.0:8000"
MODULE="app:app"

# Check for flags or default to start
ACTION=${1:-start}

# Function to start the app
start_app() {
    # Check if gunicorn is already running for this app
    if pgrep -f "gunicorn.*$MODULE" > /dev/null
    then
        echo "$(date): App is already running."
    else
        echo "$(date): App not running, starting..."
        cd $APP_PATH
        source $VENV_PATH/bin/activate
        nohup gunicorn --bind $BIND $MODULE > app.log 2>&1 &
        echo "$(date): App started."
    fi
}

# Function to stop the app
stop_app() {
    # Check if gunicorn is running for this app
    if pgrep -f "gunicorn.*$MODULE" > /dev/null
    then
        echo "$(date): Stopping app..."
        pkill -f "gunicorn.*$MODULE"
        echo "$(date): App stopped."
    else
        echo "$(date): App is not running."
    fi
}

# Function to restart the app
restart_app() {
    stop_app
    start_app
}

# Handle the action based on user input
case "$ACTION" in
    start)
        start_app
        ;;
    stop)
        stop_app
        ;;
    restart)
        restart_app
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

