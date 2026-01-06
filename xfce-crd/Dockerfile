# default cloud workstations image
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# apply update
#RUN apt-get update && apt-get upgrade -y
RUN apt-get update
RUN apt-get install curl gpg wget

RUN curl https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor -o /etc/apt/trusted.gpg.d/chrome-remote-desktop.gpg
RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main" \
    | sudo tee /etc/apt/sources.list.d/chrome-remote-desktop.list

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  tee /etc/apt/sources.list.d/antigravity.list > /dev/null

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes chrome-remote-desktop

RUN DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver

RUN bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

RUN curl -L -o google-chrome-stable_current_amd64.deb \
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install --assume-yes --fix-broken ./google-chrome-stable_current_amd64.deb

RUN apt install antigravity

COPY files/010_add-user.sh /etc/workstation-startup.d/
COPY files/200_setup_crd.sh /etc/workstation-startup.d/
COPY files/entrypoint.sh /google/scripts/