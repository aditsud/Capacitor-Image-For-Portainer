FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# =========================================================
# Basic packages
# =========================================================
RUN apt-get update && \
    apt-get install -y \
        curl \
        wget \
        unzip \
        git \
        && \
    rm -rf /var/lib/apt/lists/*

# =========================================================
# Code Server
# =========================================================
ARG CODE_SERVER_VERSION=4.103.2

RUN curl -fOL \
    https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    dpkg -i code-server_${CODE_SERVER_VERSION}_amd64.deb && \
    rm code-server_${CODE_SERVER_VERSION}_amd64.deb


# =========================================================
# Working directory
# =========================================================
WORKDIR /workspace

# =========================================================
# Code Server
# =========================================================
EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "/workspace"]
