# geckodriver-arm-binaries

This repo contains the latest ARM64 binary of linux-arm64 geckodriver and instructions to build it on ARM64 hardware using a container image.


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


## License

Copyright (c) James Mortensen, 2022 MIT License


# geckodriver Source code

geckodriver is made available under the [Mozilla Public License](https://www.mozilla.org/en-US/MPL/2.0/).

Its source code can be found in [mozilla-central](https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver) under testing/geckodriver.
This GitHub repository is only used for building geckodriver for ARM64 and is not affiliated with Mozilla. See [mozilla/geckodriver](https://github.com/mozilla/geckodriver) for issue tracking and official Mozilla geckodriver releases.

[source code]: https://hg.mozilla.org/mozilla-unified/file/tip/testing/geckodriver
[Mozilla Public License]: https://www.mozilla.org/en-US/MPL/2.0/
[mozilla-central]: https://hg.mozilla.org/mozilla-central/file/tip/testing/geckodriver
