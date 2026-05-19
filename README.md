# tusd-custom

Custom tusd image with zstd support for extracting uploaded mission archives.

## What it does

Extends `tusproject/tusd:latest` with:
- `zstd` for decompressing `.tar.zst` archives
- `jq` for parsing hook event payloads

The `post-finish` hook extracts uploaded tar.zst archives into a sibling directory after upload completes.

## Build & Push

```bash
docker build -t ghcr.io/aerostacks/tusd-custom:latest .
docker push ghcr.io/aerostacks/tusd-custom:latest
```

## Usage

Replace `tusproject/tusd:latest` with `ghcr.io/aerostacks/tusd-custom:latest` in your docker-compose and mount the hooks directory:

```yaml
services:
  tusd_missiondata:
    image: ghcr.io/aerostacks/tusd-custom:latest
    volumes:
      - ./hooks:/srv/tusd-hooks
      - /mnt/data/storage/missiondata:/data/missiondata
    command:
      - -port
      - "7000"
      - -upload-dir
      - /data/missiondata
      - -base-path
      - /
      - -hooks-dir
      - /srv/tusd-hooks
      - -hooks-enabled-events
      - post-finish
```
