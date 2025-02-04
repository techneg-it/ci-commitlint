FROM node:22-bookworm-slim@sha256:13b326848fbcfb58e5573e0904fc495967c7d8a9b0007cd95faed0508d164b54

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.7.1
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=19.7.1

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
