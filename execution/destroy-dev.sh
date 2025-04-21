#!/bin/bash

TG_DOWNLOAD_DIR="./terragrunt-cache" \
terragrunt run-all destroy --backend-bootstrap --working-dir envs/dev