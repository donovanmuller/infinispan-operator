#!/usr/bin/env bash

KUBECONFIG=${1-openshift.local.clusterup/openshift-apiserver/admin.kubeconfig}

echo "Using KUBECONFIG '$KUBECONFIG'"

VERSION=$(git describe --tags --always --dirty)
GO_LDFLAGS="-X github.com/infinispan/infinispan-operator/version.Version=${VERSION}"

go clean -testcache ./test/e2e
if [ -z "${TEST_NAME}" ]; then
  go test -v ./test/e2e -timeout 45m -ldflags "${GO_LDFLAGS}"
else
  echo "Running test '$TEST_NAME'"
  go test -v ./test/e2e -timeout 45m -ldflags "${GO_LDFLAGS}" -run "${TEST_NAME}"
fi
