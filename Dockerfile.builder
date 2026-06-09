FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    CARGO_HOME=/root/.cargo \
    RUSTUP_HOME=/root/.rustup \
    PATH="/root/.cargo/bin:${PATH}" \
    PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig:/usr/lib/pkgconfig"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    build-essential \
    pkg-config \
    xz-utils \
    libgtk-3-dev \
    libwebkit2gtk-4.0-dev \
    libsoup-3.0-dev \
    libsoup2.4-dev \
    libjavascriptcoregtk-4.0-dev \
    librsvg2-dev \
    libssl-dev \
    libayatana-appindicator3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup default stable

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm@9

WORKDIR /src
CMD ["bash"]
