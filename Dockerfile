# damon/ssh
#
# docker run -id -p 22 damon/ssh
#
# VERSION 0.0.1

FROM ubuntu:precise

# Update, then set the locale
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -qq && \
    locale-gen en_US.UTF-8 && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Force the lang and lc
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -qq

# Fix some issues with APT packages.
# See https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl

# Install the ssh server package
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq openssh-server

# Add the SSH dir
RUN mkdir -p /var/run/sshd

# Set home for root
ENV HOME /root
ENV USER root
RUN mkdir -p "${HOME}/.ssh"

# Set the root password to root
RUN echo "root:root" | chpasswd

# Expose the ssh port
EXPOSE 22

# Run ssh without daemonizing
CMD ["/usr/sbin/sshd", "-D"]
