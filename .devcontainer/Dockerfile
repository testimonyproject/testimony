# Shared by the devcontainer and CI (see .github/workflows/devcontainer-image.yml,
# ci.yml, docs.yml) so that "it works locally" and "it works in CI" mean the
# same toolchain, not just the same commands.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/.elan/bin:/root/.local/bin:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential ca-certificates curl git python3 libgraphite2-3 \
    && rm -rf /var/lib/apt/lists/*

# elan, installed the same way ci.yml does it.
RUN curl -sSfL https://github.com/leanprover/elan/releases/latest/download/elan-x86_64-unknown-linux-gnu.tar.gz | tar xz \
    && ./elan-init -y --default-toolchain none \
    && rm elan-init

# Pin the toolchain lean-toolchain names (leanprover/lean4:v4.33.1) into the
# image, so a fresh worktree needs the network only for `lake exe cache get`,
# not for the compiler itself.
COPY lean-toolchain /tmp/lean-toolchain
RUN elan toolchain install "$(cat /tmp/lean-toolchain)" && rm /tmp/lean-toolchain

# tectonic: docs/latex/arguments.tex needs a Unicode LaTeX engine.
RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh \
    && mv tectonic /usr/local/bin/tectonic

# mdbook, pinned to the version docs.yml and ci.yml have used.
RUN mkdir -p /root/.local/bin \
    && curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.40/mdbook-v0.4.40-x86_64-unknown-linux-gnu.tar.gz \
        | tar -xz -C /root/.local/bin

WORKDIR /workspaces/testimony
