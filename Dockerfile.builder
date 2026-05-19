# =============================================
# 迷雾通5 (Geph5) 多版本构建环境
# 支持 Ubuntu 22.04 和 24.04
# =============================================

# ==================== Ubuntu 22.04 ====================
FROM ubuntu:22.04 AS builder22

ENV DEBIAN_FRONTEND=noninteractive \
    CARGO_HOME=/root/.cargo \
    RUSTUP_HOME=/root/.rustup \
    PATH="/root/.cargo/bin:${PATH}"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl git build-essential pkg-config sudo xz-utils \
    libgtk-3-dev libayatana-appindicator3-dev \
    libwebkit2gtk-4.0-dev libsoup2.4-dev libjavascriptcoregtk-4.0-dev \
    librsvg2-dev libssl-dev patchelf strace \
    libpango1.0-dev libgdk-pixbuf2.0-dev \
    gcc clang g++ zlib1g-dev \
    libmpc-dev libmpfr-dev libgmp-dev \
    libprotobuf-dev protobuf-compiler cmake libprotobuf-c-dev \
    libglib2.0-dev libcairo2-dev libatk1.0-dev \
    libatk-bridge2.0-dev libxkbcommon-dev libxdo-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup default stable

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm@9

WORKDIR /src
CMD ["bash"]

# ==================== Ubuntu 24.04 ====================
FROM ubuntu:24.04 AS builder24

ENV DEBIAN_FRONTEND=noninteractive \
    CARGO_HOME=/root/.cargo \
    RUSTUP_HOME=/root/.rustup \
    PATH="/root/.cargo/bin:${PATH}"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl git build-essential pkg-config sudo xz-utils \
    libgtk-3-dev libayatana-appindicator3-dev \
    libwebkit2gtk-4.1-dev libsoup3-dev libjavascriptcoregtk-4.1-dev \
    librsvg2-dev libssl-dev patchelf strace \
    libpango1.0-dev libgdk-pixbuf2.0-dev \
    gcc clang g++ zlib1g-dev \
    libmpc-dev libmpfr-dev libgmp-dev \
    libprotobuf-dev protobuf-compiler cmake libprotobuf-c-dev \
    libglib2.0-dev libcairo2-dev libatk1.0-dev \
    libatk-bridge2.0-dev libxkbcommon-dev libxdo-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup default stable

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm@9

WORKDIR /src
CMD ["bash"]
