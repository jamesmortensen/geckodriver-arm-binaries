#!/bin/bash
TARGET=${1:-release}

if [ "$TARGET" = "release" ]; then
    cargo build --release
else
    cargo build
fi

cp /opt/geckodriver/target/$TARGET/geckodriver /media/host
