#!/bin/bash

# Config the files and prepare a desktop for CRD
PIN="${PIN:-123456}"
USER_ID=user
runuser $USER_ID -c "mkdir -p /home/$USER_ID/.config/chrome-remote-desktop"
runuser $USER_ID -c "mkdir /home/$USER_ID/.config/chrome-remote-desktop/crashpad"
runuser $USER_ID -c "chmod a+rx /home/$USER_ID/.config/chrome-remote-desktop"
runuser $USER_ID -c "echo \"/usr/bin/pulseaudio --start\" > /home/$USER_ID/.chrome-remote-desktop-session"
runuser $USER_ID -c "echo \"startxfce4 :1030\" >> /home/$USER_ID/.chrome-remote-desktop-session"

runuser $USER_ID -c "DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=$CODE --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=$HOSTNAME --pin=$PIN"