#!/bin/bash

/usr/bin/workstation-startup

service chrome-remote-desktop stop
service chrome-remote-desktop start

runuser user -c "sleep infinity"
