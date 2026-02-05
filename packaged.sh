#!/bin/sh

apt update
apt install -y software-properties-common
add-apt-repository -y ppa:ubuntuhandbook1/emacs
apt update
DEBIAN_FRONTEND=noninteractive apt install -q -y \
                               autoconf \
                               binutils \
                               build-essential \
                               caddy \
                               clang \
                               curl \
                               direnv \
                               file \
                               file \
                               gdb \
                               git \
                               gnutls-dev \
                               golang-go \
                               iputils-ping \
                               lldb \
                               magic-wormhole \
                               make \
                               mosh \
                               mtr \
                               netcat-openbsd \
                               pkg-config \
                               ripgrep \
                               snapd \
                               software-properties-common \
                               sqlite3 \
                               tmux \
                               traceroute \
                               vim \
                               whois \
                               wget \
                               wormhole \
                               zip \
                               zsh
DEBIAN_FRONTEND=noninteractive apt dist-upgrade
