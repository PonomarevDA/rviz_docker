#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_DIR="${SCRIPT_DIR}/models"

# Check if a model name is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <model_name>"
    echo "Supported models:"
    for model in "$MODELS_DIR"/*/; do
        if [ -d "$model" ]; then
            echo "- $(basename "$model")"
        fi
    done
    echo "Example: $0 hany"
    exit 1
fi

MODEL_NAME="$1"

xhost +local:docker  # Allow local docker containers to connect to the X server

docker rm rviz_container || true
docker run -it \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device=/dev/dri \
    --volume="$(pwd)/config:/workspace/config:rw" \
    --volume="$(pwd)/models:/workspace/models:ro" \
    --name rviz_container \
    rviz_noetic ./start.sh ${MODEL_NAME}
