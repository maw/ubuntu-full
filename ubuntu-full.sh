#!/bin/bash

export home="$HOME"

image=ubuntu-full:latest

# docker volume create ubuntu-full-rustup
# docker volume create ubuntu-full-cargo
docker volume create ubuntu-full-home

# docker run --rm \
#        -v ubuntu-full-rustup:/tmp/rustup \
#        -v ubuntu-full-cargo:/tmp/cargo \
#        -v /etc:/etc \
#        ubuntu-full:2025-11-25_01 \
#        sh -c "chown -R $me $home"

docker run -it -u "$UID:$GID" \
       -v ubuntu-full-home:/home/ \
       -v "$home/.zshrc":"$home/.zshrc" \
       -v "$home/.zsh-nvm:$home/.zsh-nvm" \
       -v "$home/.oh-my-zsh:$home/.oh-my-zsh" \
       -v "$(pwd):/work" \
       -v ubuntu-full-rustup:"$home/.rustup" \
       -v ubuntu-full-cargo:"$home/.cargo" \
       "$image" zsh
