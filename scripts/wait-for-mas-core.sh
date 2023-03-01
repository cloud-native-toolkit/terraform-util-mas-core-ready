#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

if [[ -n "${BIN_DIR}" ]]; then
  export PATH="${BIN_DIR}:${PATH}"
fi

source "${SCRIPT_DIR}/support-functions.sh"

NAMESPACE="$1"
INSTANCE_ID="$2"

if [[ -z "${KUBECONFIG}" ]]; then
  echo "KUBECONFIG must be set" >&2
  exit 1
fi

if [[ -z "${NAMESPACE}" ]]; then
  echo "namespace is required as first argument" >&2
  exit 1
fi

if [[ -z "${INSTANCE_ID}" ]]; then
  echo "mas_instance_id is required as second argument" >&2
  exit 1
fi

if ! command -v jq 1> /dev/null 2> /dev/null; then
  echo "jq cli not found" >&2
  exit 1
fi

if ! command -v kubectl 1> /dev/null 2> /dev/null; then
  echo "kubectl cli not found" >&2
  exit 1
fi

# wait for namespace
check_k8s_namespace "${NAMESPACE}" || exit 1

# wait for resource
check_k8s_resource "${NAMESPACE}" suite "${INSTANCE_ID}" || exit 1

# wait for status
count=0
limit=40
while [[ $count -lt $limit ]]; do
  RESULT=$(kubectl get -n "${NAMESPACE}" suite "${INSTANCE_ID}" -o json)

  CONDITION=$(echo "${RESULT}" | jq -c '.status.conditions[] | select(.type == "SLSIntegrationReady")')

  SLS_INTEGRATION_REASON=$(echo "${CONDITION}" | jq -r '.reason')
  echo "SLS Integration reason: ${SLS_INTEGRATION_REASON}"
  if [[ "${SLS_INTEGRATION_REASON}" == "Ready" ]]; then
    break
  fi

  echo "**** Suite result ****"
  echo "${RESULT}"

  count=$((count + 1))
  sleep 90
done

if [[ "$count" -eq $limit ]]; then
  echo "Timed out waiting for MAS core instance: ${NAMESPACE}/suite/${INSTANCE_ID}" >&2
  kubectl get -n "${NAMESPACE}" suite "${INSTANCE_ID}" -o json >&2
  exit 1
fi
