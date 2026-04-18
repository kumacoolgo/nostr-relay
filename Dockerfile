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

RUN which flatc && flatc --version
RUN ls /usr/include/flatbuffers/flatbuffers.h
RUN ls /usr/include/lmdb.h
RUN ls /usr/include/zstd.h
RUN ls /usr/include/secp256k1_schnorrsig.h

RUN git clone --recursive https://github.com/hoytech/strfry.git /app \
    && cd /app \
    && make -j"$(nproc)"

WORKDIR /app

RUN mkdir -p /data

COPY strfry.conf /app/strfry.conf

EXPOSE 7777

CMD ["./strfry", "relay", "--config", "/app/strfry.conf"]
