FROM node:21-bookworm-slim@sha256:45a1840087f9d9f75e38afb5afd9307df1a64b101563e8e865eb11a8008f008e

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.2.2
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=19.2.2

# Avoid unnecessary files when installing packages
COPY files/dpkg-nodoc /etc/dpkg/dpkg.cfg.d/01_nodoc
COPY files/apt-no-recommends /etc/apt/apt.conf.d/99synaptic

SHELL ["/bin/bash", "-x", "-o", "pipefail", "-c"]
RUN : \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
    && git config --global user.name "Null" \
    && git config --global user.email "null@example.com" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && :

RUN : \
    && npm install -g @commitlint/cli@${CL_CLI_VERSION} \
        @commitlint/config-conventional@${CL_CC_VERSION} \
    && :
