#!/bin/bash
set -eo pipefail

SECONDS=0

# required environment variables
: "${AWS_ACCESS_KEY_ID:?Please set the environment variable.}"
: "${AWS_REGION:?Please set the environment variable.}"
: "${AWS_S3_ENDPOINT:?Please set the environment variable.}"
: "${AWS_SECRET_ACCESS_KEY:?Please set the environment variable.}"
: "${MYSQL_DB:?Please set the environment variable.}"
: "${MYSQL_PASSWORD:?Please set the environment variable.}"

# optional environment variables with defaults
AWS_S3_STORAGE_CLASS="${AWS_S3_STORAGE_CLASS:-STANDARD_IA}"
MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-root}"

# logic starts here
BACKUP_FILE_NAME=$(date +"${MYSQL_DB}-%F_%T.gz")

echo "Dumping the database..."
mysqldump \
  --host "${MYSQL_HOST}" \
  --port "${MYSQL_PORT}" \
  --user "${MYSQL_USER}" \
  --password="${MYSQL_PASSWORD}" \
  "${MYSQL_DB}" | pigz --fast > "${BACKUP_FILE_NAME}"
echo "Dumping the database... Done."

echo "Uploading to S3..."
rclone copyto \
  --s3-no-check-bucket \
  "./${BACKUP_FILE_NAME}" \
  ":s3,access_key_id=${AWS_ACCESS_KEY_ID},provider=AWS,region=${AWS_REGION},secret_access_key=${AWS_SECRET_ACCESS_KEY},storage_class=${AWS_S3_STORAGE_CLASS}:${AWS_S3_ENDPOINT}/${BACKUP_FILE_NAME}"
echo "Uploading to S3... Done."

if [ -n "${WEBGAZER_HEARTBEAT_URL}" ]; then
  curl "${WEBGAZER_HEARTBEAT_URL}?seconds=${SECONDS}"
fi
