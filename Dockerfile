FROM debian:bookworm

RUN apt update && apt install -y \
    git build-essential pkg-config libssl-dev ca-certificates

# 安装 strfry
RUN git clone https://github.com/hoytech/strfry.git /app \
    && cd /app && make

WORKDIR /app

# 创建数据目录
RUN mkdir -p /data

# 默认配置
COPY strfry.conf /app/strfry.conf

EXPOSE 7777

CMD ["./strfry", "relay", "--config", "/app/strfry.conf"]
