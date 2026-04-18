FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    pkg-config \
    cmake \
    wget \
    ca-certificates \
    libssl-dev \
    zlib1g-dev \
    liblmdb-dev \
    lmdb-utils \
    flatbuffers-compiler \
    libflatbuffers-dev \
    libzstd-dev \
    libsecp256k1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/hoytech/strfry.git /app \
    && cd /app \
    && make -j"$(nproc)"

WORKDIR /app

RUN mkdir -p /data/db

COPY strfry.conf /app/strfry.conf

EXPOSE 7777

CMD ["./strfry", "relay", "--config", "/app/strfry.conf"]
