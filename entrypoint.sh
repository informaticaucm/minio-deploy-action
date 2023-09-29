#!/usr/bin/env bash

set -euxo pipefail

MC_OPTS=""
if [[ "$MINIO_INSECURE" == "true" ]]; then
  MC_OPTS="$MC_OPTS --insecure"
fi

MC_MIRROR_OPTS=""
if [[ "$MINIO_REMOVE" == "true" ]]; then
  MC_MIRROR_OPTS="$MC_OPTS --remove"
fi

mc alias set ${MC_OPTS} deploy "$MINIO_ENDPOINT" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY"

mc mirror --overwrite ${MC_MIRROR_OPTS} $1 "deploy/$2"
