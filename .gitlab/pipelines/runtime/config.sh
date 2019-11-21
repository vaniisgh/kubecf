#!/usr/bin/env bash

export KUBECF_NAMESPACE="kubecf"
export CF_OPERATOR_NAMESPACE="cfo"
export CLUSTER_IP="10.96.0.255"
export SYSTEM_DOMAIN="172.17.0.2.nip.io"
: "${EIRINI_ENABLED:=true}"
export EIRINI_ENABLED
export KUBECF_CHART_TARGET="//deploy/helm/kubecf:chart"
export BOSHDEPLOYMENT_CRD="boshdeployments.quarks.cloudfoundry.org"
