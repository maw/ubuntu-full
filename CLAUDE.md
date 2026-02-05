# ubuntu-full

Personal, disposable Docker environment for one-off testing, builds, and experimentation. Not distributed (neither images nor definitions).

## What this is

An Ubuntu 24.04-based Docker image bundling a broad set of development tools: C/C++ (build-essential, clang, gdb, lldb), Rust (copied from official image), Go (copied from official image), Python tooling (uv/uvx), plus common utilities (git, ripgrep, tmux, zsh, etc.). The full package list is in `packaged.sh`.

## Structure

- `Dockerfile` — image definition; uses multi-stage copies for Rust, Go, and uv
- `compose.yaml` — declares the build, volumes, and mounts
- `packaged.sh` — apt packages installed during build
- `uf` — launcher script; can be symlinked/aliased onto `$PATH`
- `rust.sh`, `uv.sh` — vestigial installer scripts (Rust and uv are now copied directly in the Dockerfile)
- `ubuntu-full.sh` — old launcher script, superseded by `uf` + compose

## Building and running

`uf` invokes `docker compose run` against `compose.yaml`, resolving the compose file relative to the script so it works from any directory. The caller's `$PWD` is mounted as `/work`.

```
uf              # run (builds image on first use)
uf --build      # rebuild image and run
uf bash         # override the default command (zsh)
```

Compose tags the image as `ubuntu-full:latest` automatically; no manual tagging needed. Named volumes (`ubuntu-full-home`, `ubuntu-full-rustup`, `ubuntu-full-cargo`) are created on first run.
