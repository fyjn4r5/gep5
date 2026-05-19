# =============================================
# 迷雾通5 (Geph5) 构建环境 - Ubuntu 22.04 加强版
# =============================================

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    CARGO_HOME=/root/.cargo \
    RUSTUP_HOME=/root/.rustup \
    PATH="/root/.cargo/bin:${PATH}" \
    PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig:/usr/lib/pkgconfig"

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl git build-essential pkg-config sudo xz-utils \
    libgtk-3-dev libayatana-appindicator3-dev \
    libwebkit2gtk-4.0-dev \
    libsoup-3.0-dev \                    # ← 增加 soup3 支持
    libsoup2.4-dev \                     # ← 保留兼容
    libjavascriptcoregtk-4.0-dev \
    librsvg2-dev libssl-dev patchelf strace \
    libpango1.0-dev libgdk-pixbuf2.0-dev \
    gcc clang g++ zlib1g-dev \
    libmpc-dev libmpfr-dev libgmp-dev \
    libprotobuf-dev protobuf-compiler cmake libprotobuf-c-dev \
    libglib2.0-dev libcairo2-dev libatk1.0-dev \
    libatk-bridge2.0-dev libxkbcommon-dev libxdo-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 强制修复 pkg-config 链接
RUN find /usr -name "libsoup*.pc" -exec ln -sf {} /usr/share/pkgconfig/ \; 2>/dev/null || true && \
    find /usr -name "libsoup*.pc" -exec ln -sf {} /usr/lib/x86_64-linux-gnu/pkgconfig/ \; 2>/dev/null || true && \
    find /usr -name "libjavascriptcoregtk*.pc" -exec ln -sf {} /usr/share/pkgconfig/ \; 2>/dev/null || true

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup default stable

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm@9

WORKDIR /src
CMD ["bash"]
