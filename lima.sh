#!/usr/bin/env bash
set -eu

cat <<EOF >"${EDITION}.yaml"
arch: "${ARCH}"
images:
- location: "${PWD}/iso/alpine-lima-${EDITION}-${ALPINE_VERSION}-${ARCH}.iso"
  arch: "${ARCH}"
mounts:
- location: "~"
  writable: false
- location: "/tmp/lima"
  writable: true
ssh:
  localPort: 40022
firmware:
  legacyBIOS: true
video:
  display: cocoa
containerd:
  system: false
  user: false
EOF

limactl delete -f "${EDITION}"
limactl start --tty=false "${EDITION}.yaml"
