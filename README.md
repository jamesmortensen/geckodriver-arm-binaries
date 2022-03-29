# Unofficial geckodriver-arm-binaries

NOTE: These are unofficial binaries. They are not provided by Mozilla but instead compiled and built independently. Use at your own risk. If you have concerns, please follow the steps below to build the binaries yourself.  See [geckodriver source code and license](#geckodriver-source-code-and-license) for more details.

This repo contains the following unofficial geckodriver arm binaries:

- [unofficial latest ARM binaries of linux geckodriver](https://github.com/jamesmortensen/geckodriver-arm-binaries/releases) 


You may download the ones provided. Otherwise, see the below instructions to build it on arm64 or armhf hardware using a container image.


## Build Container Image

```
$ docker build -t local/geckodriver-arm64-builder:0.30.0 .
```

## Build geckodriver ARM64 binary

### Release build

```
$ docker run --rm -it -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-arm64-builder local/geckodriver-arm64-builder:0.30.0
```

### Debug build

```
$ docker run --rm -it -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-arm64-builder local/geckodriver-arm64-builder:0.30.0 bash -c "sh build-geckodriver-arm64.sh debug"
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
$ docker buildx build --platform linux/arm/v7 -t local/geckodriver-armv7-builder:0.30.0 .
```

Then build the geckodriver binary. Here's an example building geckodriver for armhf with QEMU:

```
docker run --rm -it --platform linux/arm/v7 -v $PWD/artifacts:/media/host -w /opt/geckodriver --name geckodriver-armv7-builder local/geckodriver-armv7-builder:0.30.0
```


### Additional information

The binary is copied to $PWD/artifacts.  If you're using podman-machine or running Docker in a VM, then you'll need to copy the binary from Podman or the VM via scp or by mounting a shared volume.


# geckodriver source code and license

geckodriver is made available under the [Mozilla Public License](https://www.mozilla.org/en-US/MPL/2.0/) and is a product of Mozilla.

Its source code can be found in [mozilla-central](https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver) under testing/geckodriver.
This unofficial GitHub repository is only used for building geckodriver for ARM and is not affiliated with Mozilla. See [mozilla/geckodriver](https://github.com/mozilla/geckodriver) for issue tracking and official Mozilla geckodriver releases.

[source code]: https://hg.mozilla.org/mozilla-unified/file/tip/testing/geckodriver
[Mozilla Public License]: https://www.mozilla.org/en-US/MPL/2.0/
[mozilla-central]: https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver
