#!/bin/bash

/usr/bin/antigravity \
  --disable-gpu \
  --disable-dev-shm-usage \
  --no-sandbox \
  --js-flags="--no-opt" \
  "$@"
