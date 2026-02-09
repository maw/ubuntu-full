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
RUN chmod -R a+rwX $RUSTUP_HOME $CARGO_HOME

COPY --from=docker.io/golang:1.25.4-trixie /go /go
COPY --from=docker.io/golang:1.25.4-trixie /usr/local/go /usr/local/go

COPY --from=docker.io/astral/uv:latest /uv /uvx /bin/

# Node.js + pnpm (via corepack)
COPY --from=docker.io/node:22-slim /usr/local/bin/node /usr/local/bin/
COPY --from=docker.io/node:22-slim /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=docker.io/node:22-slim /usr/local/include/node /usr/local/include/node
RUN ln -s ../lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx \
    && ln -s ../lib/node_modules/corepack/dist/corepack.js /usr/local/bin/corepack
ENV COREPACK_HOME=/usr/local/share/corepack
RUN corepack enable pnpm && corepack prepare pnpm@latest --activate

COPY rust.sh /rust.sh
RUN chmod +x /rust.sh
RUN /rust.sh


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ENV PATH=/go/bin:/usr/local/go/bin:$PATH

