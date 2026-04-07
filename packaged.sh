#!/bin/sh

apt update
apt install -y software-properties-common
add-apt-repository -y ppa:ubuntuhandbook1/emacs
apt update

# Keep the list of packages sorted
PACKAGES="
autoconf
bind9-dnsutils
binutils
build-essential
caddy
clang
curl
direnv
file
gdb
git
gnutls-dev
golang-go
iputils-ping
lldb
magic-wormhole
make
mosh
mtr
netcat-openbsd
pkg-config
ripgrep
snapd
software-properties-common
sqlite3
sudo
tmux
traceroute
vim
whois
wget
wormhole
zip
zsh
"

DEBIAN_FRONTEND=noninteractive apt install -q -y $PACKAGES
DEBIAN_FRONTEND=noninteractive apt dist-upgrade
