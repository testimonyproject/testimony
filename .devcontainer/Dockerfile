# Shared by the devcontainer and CI (see .github/workflows/devcontainer-image.yml,
# ci.yml, docs.yml) so that "it works locally" and "it works in CI" mean the
# same toolchain, not just the same commands.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/root/.elan/bin:/root/.local/bin:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential ca-certificates curl git python3 libgraphite2-3 \
    && rm -rf /var/lib/apt/lists/*

# elan, installed the same way ci.yml does it. Arch-aware so this also works
# on arm64 builders (Apple Silicon under OrbStack/Rosetta) — a hardcoded
# x86_64 binary fails there with "Dynamic loader not found:
# /lib64/ld-linux-x86-64.so.2" since there's no multi-arch emulation at
# container runtime.
RUN case "$(uname -m)" in \
        x86_64) ELAN_ARCH=x86_64-unknown-linux-gnu ;; \
        aarch64) ELAN_ARCH=aarch64-unknown-linux-gnu ;; \
        *) echo "unsupported architecture for elan: $(uname -m)" >&2; exit 1 ;; \
    esac \
    && curl -sSfL "https://github.com/leanprover/elan/releases/latest/download/elan-${ELAN_ARCH}.tar.gz" | tar xz \
    && ./elan-init -y --default-toolchain none \
    && rm elan-init

# Pin the toolchain lean-toolchain names (leanprover/lean4:v4.33.1) into the
# image, so a fresh worktree needs the network only for `lake exe cache get`,
# not for the compiler itself.
COPY lean-toolchain /tmp/lean-toolchain
RUN elan toolchain install "$(cat /tmp/lean-toolchain)" && rm /tmp/lean-toolchain

# tectonic: docs/latex/arguments.tex needs a Unicode LaTeX engine.
# Downloaded directly rather than via the upstream installer script: that
# script detects glibc via `ldd --version` and always asks for a "-gnu"
# build, but tectonic 0.17.0 only ships aarch64 Linux binaries linked against
# musl (which run fine on glibc hosts, being static) — so on arm64 builders
# (Apple Silicon under Rosetta/qemu) the installer 404s.
RUN case "$(uname -m)" in \
        x86_64) TECTONIC_ARCH=x86_64-unknown-linux-gnu ;; \
        aarch64) TECTONIC_ARCH=aarch64-unknown-linux-musl ;; \
        *) echo "unsupported architecture for tectonic: $(uname -m)" >&2; exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%400.17.0/tectonic-0.17.0-${TECTONIC_ARCH}.tar.gz" \
        | tar xz \
    && mv tectonic /usr/local/bin/tectonic

# mdbook, pinned to the version docs.yml and ci.yml have used. mdBook doesn't
# ship an aarch64-gnu build, so arm64 gets the musl one (static, runs fine on
# a glibc host) — same reasoning as the tectonic build above.
RUN case "$(uname -m)" in \
        x86_64) MDBOOK_ARCH=x86_64-unknown-linux-gnu ;; \
        aarch64) MDBOOK_ARCH=aarch64-unknown-linux-musl ;; \
        *) echo "unsupported architecture for mdbook: $(uname -m)" >&2; exit 1 ;; \
    esac \
    && mkdir -p /root/.local/bin \
    && curl -sSL "https://github.com/rust-lang/mdBook/releases/download/v0.4.40/mdbook-v0.4.40-${MDBOOK_ARCH}.tar.gz" \
        | tar -xz -C /root/.local/bin

WORKDIR /workspaces/testimony
