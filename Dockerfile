FROM node:22-bookworm-slim@sha256:767d69b8c5a0f09d0e5bbaa0c8be552547c3757e99fb2bb5538004f517cc1970

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.8.0
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=19.8.0

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
