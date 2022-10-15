# Unofficial geckodriver-arm-binaries

NOTE: These are unofficial binaries. They are not provided by Mozilla but instead compiled and built independently. Use at your own risk. If you have concerns, please follow the steps below to build the binaries yourself.  See [geckodriver source code and license](#geckodriver-source-code-and-license) for more details.

**NOTE: Mozilla has released geckodriver for linux-aarch64. Please use their official aarch64 release instead of the unofficial one here. In the meantime, I have build linux-aarch64 to help make the transition easier. I will continue to build geckodriver linux-armv7.**

**See [mozilla/geckodriver releases](https://github.com/mozilla/geckodriver/releases) to download the official linux-aarch64 geckodriver binary.**

-----

This repo contains the following unofficial geckodriver arm binaries:

- [unofficial latest ARM binaries of linux geckodriver](https://github.com/jamesmortensen/geckodriver-arm-binaries/releases) 


You may download the ones provided. Otherwise, see the below instructions to build it on arm64 or armhf hardware using a container image.


## Build Container Image

```
$ docker build --build-arg GECKODRIVER_VERSION=0.32.0 -t local/geckodriver-arm-builder .
```

## Build geckodriver ARM64 binary

### Release build

```
$ docker run --rm -it -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-arm-builder local/geckodriver-arm-builder
```

### Debug build

```
$ docker run --rm -it -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-arm-builder local/geckodriver-arm-builder bash -c "sh build-geckodriver-arm.sh debug"
```

## Building with QEMU emulation

If you're not on an arm64 platform or wish to build for another platform, such as armv7, or arm64 if you're on x86_64, you can use QEMU emulation to build the driver:

First, unregister any platforms already registered:

```
$ docker run --rm -it --privileged aptman/qus -- -r
```

Next, re-register the emulated architectures:

```
$ docker run --rm -it --privileged aptman/qus -s -- -p
```

Then, build the container image with buildx:

```
$ docker buildx build --platform linux/arm/v7 --build-arg GECKODRIVER_VERSION=0.32.0 -t local/geckodriver-arm-builder .
```

Then build the geckodriver binary. Here's an example building geckodriver for armhf with QEMU:

```
docker run --rm -it --platform linux/arm/v7 -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-arm-builder local/geckodriver-arm-builder
```

## Building with cross-compilation

It's also possible to build a geckodriver binary on one host architecture that targets another architecture. This information is adapted from Mozilla's developer documentation on [Self Serving an ARM build](https://firefox-source-docs.mozilla.org/testing/geckodriver/ARM.html).

### armv7l/armhf

If you don’t have Rust installed:
```
# curl https://sh.rustup.rs -sSf | sh
```

Install cross-compiler toolchain:
```
# apt install gcc-arm-linux-gnueabihf libc6-armhf-cross libc6-dev-armhf-cross
```

Create a new shell, or to reuse the existing shell:
```
source $HOME/.cargo/env
```

Install rustc target toolchain:
```
% rustup target install armv7-unknown-linux-gnueabihf
```

Put this in testing/geckodriver/.cargo/config:
```
[target.armv7-unknown-linux-gnueabihf]
linker = "arm-linux-gnueabihf-gcc"
```

Build geckodriver from testing/geckodriver:
```
% cd testing/geckodriver
% cargo build --release --target armv7-unknown-linux-gnueabihf
```

### aarch64/arm64

Install cross-compiler toolchain:
```
$ apt install gcc-aarch64-linux-gnu libc6-arm64-cross libc6-dev-arm64-cross
```

Create a new shell, or to reuse the existing shell:
```
$ source $HOME/.cargo/env
```

Install rustc target toolchain:
```
$ rustup target install aarch64-unknown-linux-gnu
```

Put this in testing/geckodriver/.cargo/config:
```
[target.aarch64-unknown-linux-gnu]
linker = "aarch64-linux-gnu-gcc"
```

Build geckodriver from testing/geckodriver:
```
$ cargo build --release --target aarch64-unknown-linux-gnu
```

## Additional information

The binary is copied to $PWD/artifacts.  If you're using podman-machine or running Docker in a VM, then you'll need to copy the binary from Podman or the VM via scp or by mounting a shared volume.


# geckodriver source code and license

geckodriver is made available under the [Mozilla Public License](https://www.mozilla.org/en-US/MPL/2.0/) and is a product of Mozilla.

Its source code can be found in [mozilla-central](https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver) under testing/geckodriver.
This unofficial GitHub repository is only used for building geckodriver for ARM and is not affiliated with Mozilla. See [mozilla/geckodriver](https://github.com/mozilla/geckodriver) for issue tracking and official Mozilla geckodriver releases.

[source code]: https://hg.mozilla.org/mozilla-unified/file/tip/testing/geckodriver
[Mozilla Public License]: https://www.mozilla.org/en-US/MPL/2.0/
[mozilla-central]: https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver
