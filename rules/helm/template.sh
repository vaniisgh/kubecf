#!/usr/bin/env bash

set -o errexit -o nounset

source "{WORKSPACE_STATUS_ENVIRONMENT}"

if [ -z "${STABLE_KUBECF_NAMESPACE}" ]; then
  >&2 echo "KUBECF_NAMESPACE environment variable not declared"
  exit 1
fi

"{HELM}" template "${@}" \
  --name "{INSTALL_NAME}" \
  --namespace "${STABLE_KUBECF_NAMESPACE}" \
  "{CHART_PACKAGE}" > "{OUTPUT_YAML}"
