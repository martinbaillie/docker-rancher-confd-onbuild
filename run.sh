#!/usr/bin/env sh
set -e
set -u
set -o pipefail

wait_for_rancher_metadata() {
  counter=0
  printf '%s %s %s: INFO waiting for rancher-metadata to become available' \
      "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$(hostname)" "$0[$$]"
  until curl --output /dev/null --silent --head --fail \
      http://rancher-metadata.rancher.internal; do
    printf '.'
    sleep 1
    counter=$((counter + 1))
    if [ "$counter" -gt 10 ]; then
      echo
      echo "$(date -u +'%Y-%m-%dT%H:%M:%SZ') $(hostname) $0[$$]: ERROR " \
          "rancher-metadata unavailable." >&2
      exit 1
    fi
  done
  echo
}
wait_for_rancher_metadata
exec /bin/confd \
    -interval "${CONFD_INTERVAL}" \
    -backend rancher \
    -prefix "${CONFD_RANCHER_API_PREFIX}" \
    -log-level "${CONFD_LOG_LEVEL}"
