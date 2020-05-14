#!/bin/bash

TARGET=$1

set -euo pipefail


function verifyParameters() {
  if [[ -z "$TARGET" ]]; then
    echo "Set a target eg './greymatter', '*'"
    exit 1
  fi
  if [[ -z "$INPUT_NEXUS_URL" ]]; then
    echo "The Nexus URL needs to be defined"
    exit 1
  fi
    if [[ -z "$INPUT_NEXUS_USER" ]]; then
    echo "The Nexus User needs to be defined"
    exit 1
  fi
  if [[ -z "$INPUT_NEXUS_PASS" ]]; then
    echo "The Nexus Password needs to be defined"
    exit 1
  fi
  return
}

verifyParameters

if [[ -f "$TARGET/Chart.yaml" ]]; then
	chart=$(basename "$TARGET")
  # If we are packaging a parent chart, we need to get the requirements from Nexus
  if [[ "$chart" == "greymatter" ]] || [[ "$chart" == "fabric" ]] || [[ "$chart" == "data" ]] || [[ "$chart" == "sense" ]] || [[ "$chart" == "spire" ]]; then
    helm repo add decipher "$INPUT_NEXUS_URL" --username "$INPUT_NEXUS_USER" --password "$INPUT_NEXUS_PASS"
    rm -rf $TARGET/charts
    helm dependency update "$TARGET"
  fi
	echo "Packaging $chart from $TARGET"
	helm package "$TARGET"
  echo "Publishing $chart to Nexus"
  pkg=$(ls $chart*.tgz)
  curl -u "$INPUT_NEXUS_USER":"$INPUT_NEXUS_PASS" "$INPUT_NEXUS_URL" -T "$pkg"
	exit $?
else
  echo "No chart found for $TARGET"
  exit 1
fi

exit 0