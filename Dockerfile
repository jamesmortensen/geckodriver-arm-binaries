FROM debian:latest
LABEL authors=Mozilla,jamesmortensen

#========= tags
# local/geckodriver-arm64-builder:0.30.0
#=========

USER root


#===========
# Install dependencies and clone geckodriver source
#===========
WORKDIR /opt
RUN echo "deb http://ftp.hk.debian.org/debian/ sid main" >> /etc/apt/sources.list \
  && apt-get update -qqy \
  && apt install gcc build-essential git cargo ca-certificates curl --no-install-recommends -y \
  && curl https://sh.rustup.rs -sSf | bash -s -- -y \
  && git clone https://github.com/mozilla/geckodriver.git && cd geckodriver \
  && git checkout v0.30.0 \
  && apt-get autoremove && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* 

#===========
# Copy build script to container
#===========
COPY build-geckodriver-arm64.sh /opt/geckodriver/

#===========
# Build geckodriver arm64 binary and copy to $PWD/artifacts
#===========
CMD sh build-geckodriver-arm64.sh
