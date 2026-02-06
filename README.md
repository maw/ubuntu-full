# ubuntu-full

Disposable Docker environment for one-off testing, builds, and
experimentation. Ubuntu 24.04 with a broad set of development tools
pre-installed.

## What's included

- **C/C++**: build-essential, clang, gdb, lldb
- **Rust** 1.91.1 (copied from official image)
- **Go** 1.25.4 (copied from official image)
- **Python**: uv/uvx (copied from official image)
- **Utilities**: git, ripgrep, tmux, zsh, vim, curl, mosh, direnv, sqlite3,
  and more (see `packaged.sh` for the full list)

## Usage

The `uf` launcher script wraps `docker compose run`. It resolves paths
relative to itself, so it works from any directory — symlink or alias it onto
your `$PATH`.

```
uf              # start a zsh shell (builds image on first use)
uf bash         # override the default shell
```

To rebuild the image:

```
docker compose -f /path/to/compose.yaml build
```

Your `$PWD` is mounted as `/work` inside the container.

## How it works

The container starts as root, then the entrypoint script chowns volume mount
points to your host UID/GID and drops privileges via `setpriv`. This avoids
permission issues with named volumes while keeping toolchain directories
writable.

Named volumes persist state across runs for: home directory, Rust toolchain,
Cargo registry, Go packages, shell history, and SSH config.

## Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Image definition; multi-stage copies for Rust, Go, and uv |
| `compose.yaml` | Service, volumes, and bind mounts |
| `packaged.sh` | apt packages installed during build |
| `entrypoint.sh` | Chowns volumes and drops privileges |
| `rust.sh` | Symlinks cargo binaries into `/usr/local/bin` |
| `uf` | Launcher script |
