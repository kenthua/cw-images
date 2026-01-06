# default cloud workstations image
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# Install initial dependencies and setup repositories in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gpg wget && \
    # Add Chrome Remote Desktop repository
    curl https://dl.google.com/linux/linux_signing_key.pub | \
        gpg --dearmor -o /etc/apt/trusted.gpg.d/chrome-remote-desktop.gpg && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main" | \
        tee /etc/apt/sources.list.d/chrome-remote-desktop.list && \
    # Add Antigravity repository
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
        gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
        tee /etc/apt/sources.list.d/antigravity.list > /dev/null && \
    # Clean up apt cache
    rm -rf /var/lib/apt/lists/*

# Install Chrome Remote Desktop, XFCE, Chrome, and Antigravity
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        chrome-remote-desktop \
        xfce4 \
        desktop-base \
        dbus-x11 \
        xscreensaver \
        antigravity && \
    # Download and install Google Chrome
    curl -L -o /tmp/google-chrome-stable_current_amd64.deb \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y --fix-broken /tmp/google-chrome-stable_current_amd64.deb && \
    # Clean up
    rm -f /tmp/google-chrome-stable_current_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure Chrome Remote Desktop session
RUN bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

# Copy startup scripts
COPY files/010_add-user.sh /etc/workstation-startup.d/
COPY files/200_setup_crd.sh /etc/workstation-startup.d/
COPY files/entrypoint.sh /google/scripts/