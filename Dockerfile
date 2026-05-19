FROM tusproject/tusd:latest

USER root
RUN apk add --no-cache zstd jq
USER tusd
