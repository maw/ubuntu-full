#!/bin/bash

if [ -n "$TARGET_UID" ]; then
    groupadd -g "$TARGET_GID" user 2>/dev/null
    useradd -u "$TARGET_UID" -g "$TARGET_GID" -s /bin/zsh -d "$HOME" -M user 2>/dev/null
    USERNAME=$(getent passwd "$TARGET_UID" | cut -d: -f1)
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
