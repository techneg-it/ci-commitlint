FROM node:22-bookworm-slim@sha256:c407baf6e71f4127777b0b660b162e3c88c1974067b1be9f1f962709ea817d59

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=20.0.0
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=20.0.0

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
