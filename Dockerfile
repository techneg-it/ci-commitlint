FROM node:22-bookworm-slim@sha256:bac8ff0b5302b06924a5e288fb4ceecef9c8bb0bb92515985d2efdc3a2447052

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
