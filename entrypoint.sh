#!/bin/bash

if [ -n "$TARGET_UID" ]; then
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
