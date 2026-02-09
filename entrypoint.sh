#!/bin/bash

if [ -n "$TARGET_UID" ]; then
    USERNAME="user"
    groupadd -g "$TARGET_GID" "$USERNAME" 2>/dev/null
    useradd -u "$TARGET_UID" -g "$TARGET_GID" -s /bin/zsh -d "$HOME" -M "$USERNAME" 2>/dev/null
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$USERNAME"

    chown "$TARGET_UID:$TARGET_GID" \
        "$HOME" \
        /usr/local/rustup \
        /usr/local/cargo \
        "$HOME/go" \
        "$HOME/.histfile" \
        "$HOME/.ssh" \
        2>/dev/null
    exec setpriv --reuid="$TARGET_UID" --regid="$TARGET_GID" --clear-groups -- "$@"
fi

exec "$@"
