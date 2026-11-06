#!/bin/sh
set -e
CONFIG="$HOME/.gitlab-runner/config.toml"

if [ ! -f "$CONFIG" ]; then
  : "${RUNNER_TOKEN:?Set RUNNER_TOKEN to a glrt- runner token}"
  gitlab-runner register --non-interactive \
    --url "$CI_SERVER_URL" \
    --token "$RUNNER_TOKEN" \
    --executor "$RUNNER_EXECUTOR"
fi

unset RUNNER_TOKEN
exec gitlab-runner run --working-directory "$HOME" "$@"
