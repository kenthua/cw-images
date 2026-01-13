#!/bin/bash

# Config the files and prepare a desktop for CRD
PIN="${PIN:-123456}"
USER_ID="${USER_ID:-user}"
USER_HOME="/home/$USER_ID"

# Setup directories and permissions
runuser "$USER_ID" -c "
    mkdir -p '$USER_HOME/.config/chrome-remote-desktop/crashpad'
    chmod a+rx '$USER_HOME/.config/chrome-remote-desktop'
"

# Create session file with both commands
runuser "$USER_ID" -c "cat > '$USER_HOME/.chrome-remote-desktop-session' << 'EOF'
/usr/bin/pulseaudio --start
startxfce4 :1030
EOF
chmod +x '$USER_HOME/.chrome-remote-desktop-session'
"

# Perform the initial CRD / app connectivity setup with provided code
runuser $USER_ID -c "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=$CODE --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$HOSTNAME --pin=$PIN"