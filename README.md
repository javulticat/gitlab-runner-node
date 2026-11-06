# gitlab-runner-node

[![Docker Pulls](https://img.shields.io/docker/pulls/javulticat/gitlab-runner-node)](https://hub.docker.com/r/javulticat/gitlab-runner-node)

GitLab Runner with Node.js baked in. Jobs run directly in the runner's container with the shell executor.

## Run

1. In GitLab, go to Settings > CI/CD > Runners, create a runner and copy its `glrt-` token.
2. Start the container:

   ```
   docker run -d -e RUNNER_TOKEN=glrt-xxxx javulticat/gitlab-runner-node
   ```

| Variable | Default | |
| --- | --- | --- |
| `RUNNER_TOKEN` | required | Runner token (`glrt-...`) |
| `CI_SERVER_URL` | `https://gitlab.com` | GitLab instance |
| `RUNNER_EXECUTOR` | `shell` | Executor |

## License

MIT
