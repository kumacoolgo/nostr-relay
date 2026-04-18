FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    lmdb-utils \
    wget \
    ca-certificates \
    flatbuffers-compiler \
    libflatbuffers-dev \
    && rm -rf /var/lib/apt/lists/*

RUN which flatc && flatc --version
RUN ls /usr/include/flatbuffers/flatbuffers.h

RUN git clone --recursive https://github.com/hoytech/strfry.git /app \
    && cd /app \
    && make

WORKDIR /app

RUN mkdir -p /data

COPY strfry.conf /app/strfry.conf

EXPOSE 7777

CMD ["./strfry", "relay", "--config", "/app/strfry.conf"]
