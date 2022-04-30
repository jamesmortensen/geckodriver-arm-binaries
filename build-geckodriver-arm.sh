#!/bin/bash
TYPE=${1:-release}
ARCH_TUPLE=$2

# Pass as 2nd argument: aarch64-unknown-linux-gnu or armv7-unknown-linux-gnueabihf
# else if blank then build for host architecture
if [ -n "$ARCH_TUPLE" ]; then
    TARGET="--target $ARCH_TUPLE"
    . $HOME/.cargo/env
    rustup target add $ARCH_TUPLE
fi

if [ "$TYPE" = "release" ]; then
    cargo build --release $TARGET
else
    cargo build $TARGET
fi

if [ -z "$ARCH_TUPLE" ]; then
    cp /opt/geckodriver/target/$TYPE/geckodriver /media/host
else
    cp /opt/geckodriver/target/$ARCH_TUPLE/$TYPE/geckodriver /media/host
fi
