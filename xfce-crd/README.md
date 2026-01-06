# Cloud Workstation image with Chrome Remote Desktop for antigravity

# Setup

- Create your workstation cluster & configuration
- Grab the host setup code from the Chrome Remote Desktop [Access Setup](https://remotedesktop.google.com/headless)
- Set a view environment variables for your workstation
    - `CODE` = your code
    - `PIN` = your desired PIN
- Build your image
```
REPO_URL=us-central1-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE .
gcloud builds submit --tag $REPO_URL .
```

# References
- https://github.com/cardinalby/chrome-remote-desktop-image
- https://docs.cloud.google.com/workstations/docs/customize-container-images



