#!/usr/bin/env bash

set -o errexit -o pipefail

mas signin --dialog "" &> /dev/null || true

app_ids=(
  497799835 # Xcode
  803453959 # Slack
)

mas install ${app_ids[@]}
