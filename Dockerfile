FROM node:21-bookworm-slim@sha256:db308384dbc89ee55e0a6d04279a351277b2cff03c18556c347517e4a7dee470

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.3.0
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
