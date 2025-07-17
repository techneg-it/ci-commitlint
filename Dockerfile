FROM node:22-bookworm-slim@sha256:c26e3d817a783016e1927a576b12bb262ebdaa9a4338e11ed2f7b31d557289b5

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.8.1
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=19.8.1

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
