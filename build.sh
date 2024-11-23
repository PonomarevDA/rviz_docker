#!/bin/bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
set -e

python3 ${ROOT_DIR}/scripts/download.py
docker build -t rviz_noetic ${ROOT_DIR}
