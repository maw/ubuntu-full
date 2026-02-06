#!/bin/sh

## curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /rust-installer.sh

## sh /rust-installer.sh -y
cd /usr/local/cargo/bin
for i in $(ls -1); do
    ln -s $(pwd)/$i /usr/local/bin/$i
done
