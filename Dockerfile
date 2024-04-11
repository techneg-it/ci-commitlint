FROM node:21-bookworm-slim@sha256:c35abd284345d863d9f8287fda321eae2d7b7cd5d1c2859695361e9df1063259

# renovate: datasource=npm depName=@commitlint/cli
ARG CL_CLI_VERSION=19.2.1
# renovate: datasource=npm depName=@commitlint/config-conventional
ARG CL_CC_VERSION=19.1.0

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
