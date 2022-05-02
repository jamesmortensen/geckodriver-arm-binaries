#!/bin/bash
TYPE=${1:-release}
HOST_TRIPLE=$2

# Pass as 2nd argument: aarch64-unknown-linux-gnu or armv7-unknown-linux-gnueabihf
# else if blank then build for host architecture
if [ -n "$HOST_TRIPLE" ]; then
    TARGET="--target $HOST_TRIPLE"
    . $HOME/.cargo/env
    rustup target add $HOST_TRIPLE
fi

if [ "$TYPE" = "release" ]; then
    cargo build --release $TARGET
else
    cargo build $TARGET
fi

if [ -z "$HOST_TRIPLE" ]; then
    cp /opt/geckodriver/target/$TYPE/geckodriver /media/host
else
    cp /opt/geckodriver/target/$HOST_TRIPLE/$TYPE/geckodriver /media/host
fi
