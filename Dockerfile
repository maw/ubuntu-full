FROM ubuntu:24.04

LABEL maintainer="Michael Wolf <maw@pobox.com>"

COPY packaged.sh /packaged.sh
RUN chmod +x /packaged.sh && /packaged.sh

# copied from https://github.com/rust-lang/docker-rust/blob/0ad6d349fa1a5d6cc64e3bd9a27e5f6762df9abc/stable/bullseye/Dockerfile
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.91.1

COPY --from=docker.io/rust:1.91.1-bullseye $RUSTUP_HOME $RUSTUP_HOME
COPY --from=docker.io/rust:1.91.1-bullseye $CARGO_HOME $CARGO_HOME

COPY --from=docker.io/golang:1.25.4-trixie /go /go
COPY --from=docker.io/golang:1.25.4-trixie /usr/local/go /usr/local/go

COPY --from=docker.io/astral/uv:latest /uv /uvx /bin/


ENV PATH=/go/bin:/usr/local/go/bin:$PATH

