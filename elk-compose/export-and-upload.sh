#!/bin/bash

ES_HOST="http://elasticsearch:9200"
MINIO_BUCKET="elk-exports"
EXPORT_DIR="/dumps"
PATTERNS=("event-logs-" "gc-logs-" "metric-logs-")

export_to_minio() {
  for PREFIX in "${PATTERNS[@]}"; do
    INDICES=$(curl -s "$ES_HOST/_cat/indices?h=index" | grep "^${PREFIX}")

    for INDEX in $INDICES; do
      FILE="$EXPORT_DIR/${INDEX}.json.gz"
      if [[ -f "$FILE" ]]; then
        echo "[SKIP] $INDEX already exported"
        continue
      fi

      echo "[EXPORT] Dumping $INDEX"
      elasticdump --input="${ES_HOST}/${INDEX}" --output="${EXPORT_DIR}/${INDEX}.json" --type=data
      gzip -f "${EXPORT_DIR}/${INDEX}.json"

      echo "[UPLOAD] Uploading $INDEX to MinIO"
      mc alias set minio http://minio:9000 minioadmin minio12345678@
      mc mb -q --ignore-existing minio/$MINIO_BUCKET
      mc cp "$FILE" minio/$MINIO_BUCKET/
    done
  done
}

# Loop forever
while true; do
  export_to_minio
  echo "[WAIT] Sleeping for a minute..."
  sleep 60
done

