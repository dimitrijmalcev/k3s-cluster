#!/bin/bash

TG_DOWNLOAD_DIR="./terragrunt-cache" \
terragrunt run-all apply --backend-bootstrap --working-dir envs/dev