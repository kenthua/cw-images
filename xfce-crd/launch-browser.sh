#!/bin/bash
# This uses flags that disable features requiring advanced CPU instructions

/usr/bin/google-chrome \
  --disable-gpu \
  --disable-software-rasterizer \
  --disable-dev-shm-usage \
  --no-sandbox \
  --disable-features=VaapiVideoDecoder,VaapiVideoEncoder \
  --js-flags="--no-opt" \
  "$@"
