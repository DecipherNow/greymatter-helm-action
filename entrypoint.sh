#!/bin/bash

TARGET=$1
# NEXUS_URL=$2
# NEXUS_USER=$3
# NEXUS_PASS=$4

set -euo pipefail


function verifyParameters() {
  if [[ -z "$TARGET" ]]; then
    echo "Set a target eg './greymatter', '*'"
    exit 1
  fi
  if [[ -z "$NEXUS_URL" ]]; then
    echo "The Nexus URL needs to be defined"
    exit 1
  fi
    if [[ -z "$NEXUS_USER" ]]; then
    echo "The Nexus User needs to be defined"
    exit 1
  fi
  if [[ -z "$NEXUS_PASS" ]]; then
    echo "The Nexus Password needs to be defined"
    exit 1
  fi
  return
}

verifyParameters

if [[ -f "$TARGET/Chart.yaml" ]]; then
	chart=$(basename "$TARGET")
	echo "Packaging $chart from $TARGET"
	helm package "$TARGET"
  echo "Publishing $chart to Nexus"
  pkg=$(ls "*.tgz")
  curl -u "$NEXUS_USER":"$NEXUS_PASS" "$NEXUS_URL" -T "$pkg"
	exit $?
else
  echo "No chart found for $TARGET"
  exit 1
fi

exit 0