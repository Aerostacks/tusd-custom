# tusd-custom

The tusd image used for mission uploads, with the tools its hooks need.

## What it does

Extends `tusproject/tusd:latest` with:
- `zstd` for decompressing `.tar.zst` archives
- `jq` for parsing hook event payloads

The image carries no hooks. The `post-finish` hook that hands uploads to
hamburger and keeps a copy under `/data/processing` lives in
[infra-config](https://github.com/Aerostacks/infra-config) at
`unified/tusd-hooks/post-finish`, next to the compose file that mounts it.

## Build & Push

```bash
just build
```

## Usage

See `tusd_missiondata` in infra-config's `unified/docker-compose.data.yml`.
Mount the hooks directory read-only, so an upload can never change the hook
it triggers:

```yaml
services:
  tusd_missiondata:
    image: ghcr.io/aerostacks/tusd-custom:main
    volumes:
      - ./tusd-hooks:/srv/tusd-hooks:ro
      - /mnt/data/storage/missiondata:/data/missiondata
      - /mnt/data/storage/processing:/data/processing
    command:
      - -port
      - "7000"
      - -max-size
      - "8589934592"
      - -upload-dir
      - /data/missiondata
      - -base-path
      - /
      - -hooks-dir
      - /srv/tusd-hooks
      - -hooks-enabled-events
      - post-finish
```
