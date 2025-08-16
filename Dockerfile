FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get -q update && \
    apt-get purge -q -y snapd lxcfs lxd ubuntu-core-launcher snap-confine && \
    apt-get -q -y install file wget cpio rsync locales \
        build-essential libncurses5-dev python3-setuptools \
        git bzr cvs mercurial subversion libc6 unzip bc \
        vim nano && \
    apt-get -q -y autoremove && \
    apt-get -q -y clean && \
    update-locale LC_ALL=C

RUN useradd -ms /bin/bash buildroot

RUN mkdir -p /app/buildroot/dl && chown -R buildroot:buildroot /app/buildroot/dl
RUN mkdir -p /app/buildroot/output && chown -R buildroot:buildroot /app/buildroot/output

VOLUME /app/buildroot/dl
VOLUME /app/buildroot/output

USER buildroot

CMD ["/bin/bash"]
