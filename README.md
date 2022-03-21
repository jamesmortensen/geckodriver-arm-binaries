# Unofficial geckodriver-arm-binaries

NOTE: These are unofficial binaries. They are not provided by Mozilla but instead compiled and built independently. Use at your own risk. If you have concerns, please follow the steps below to build the binaries yourself.  See [geckodriver source code and license](#geckodriver-source-code-and-license) for more details.

This repo contains the unofficial latest ARM64 binary of linux-arm64 geckodriver and instructions to build it on ARM64 hardware using a container image.


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

### Additional information

The binary is copied to $PWD/artifacts.  If you're using podman-machine or running Docker in a VM, then you'll need to copy the binary from Podman or the VM via scp or by mounting a shared volume.


# geckodriver source code and license

geckodriver is made available under the [Mozilla Public License](https://www.mozilla.org/en-US/MPL/2.0/) and is a product of Mozilla.

Its source code can be found in [mozilla-central](https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver) under testing/geckodriver.
This unofficial GitHub repository is only used for building geckodriver for ARM64 and is not affiliated with Mozilla. See [mozilla/geckodriver](https://github.com/mozilla/geckodriver) for issue tracking and official Mozilla geckodriver releases.

[source code]: https://hg.mozilla.org/mozilla-unified/file/tip/testing/geckodriver
[Mozilla Public License]: https://www.mozilla.org/en-US/MPL/2.0/
[mozilla-central]: https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver
