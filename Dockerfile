# syntax=docker/dockerfile:1
ARG NODE_VERSION=lts
ARG DEBIAN_RELEASE
FROM node:${NODE_VERSION}${DEBIAN_RELEASE:+-}${DEBIAN_RELEASE}-slim

ARG TARGETARCH
ARG GITLAB_RUNNER_VERSION=latest

LABEL org.opencontainers.image.title="gitlab-runner-node" \
    org.opencontainers.image.description="GitLab Runner with Node.js baked in" \
    org.opencontainers.image.source="https://github.com/javulticat/gitlab-runner-node" \
    org.opencontainers.image.licenses="MIT" \
    io.github.javulticat.gitlab-runner-node.node-version="${NODE_VERSION}" \
    io.github.javulticat.gitlab-runner-node.gitlab-runner-version="${GITLAB_RUNNER_VERSION}"

ADD --chmod=755 \
    https://gitlab-runner-downloads.s3.amazonaws.com/${GITLAB_RUNNER_VERSION}/binaries/gitlab-runner-linux-${TARGETARCH} \
    /usr/local/bin/gitlab-runner

RUN apt-get update \
 && apt-get install --yes --no-install-recommends ca-certificates git git-lfs openssh-client \
 && git lfs install --system \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --create-home --skel /dev/null --uid 10001 runner \
 && echo 'PATH="$NPM_CONFIG_PREFIX/bin:$PATH"' > /etc/profile.d/npm-global.sh

ENV NPM_CONFIG_PREFIX=/home/runner/.npm-global \
    PATH=/home/runner/.npm-global/bin:$PATH \
    CI_SERVER_URL=https://gitlab.com \
    RUNNER_EXECUTOR=shell \
    LISTEN_ADDRESS=""

EXPOSE 9252/tcp

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh
USER runner
WORKDIR /home/runner
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
