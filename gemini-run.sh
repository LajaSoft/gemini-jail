#!/bin/sh

set -e
current_dir=$(realpath $(pwd))
script_dir=$(dirname $(realpath $0))

mkdir -p $script_dir/home/

gemini_path=/home/gemini-cli/.node-global/bin/

docker compose -f $script_dir/docker-compose.yml run --remove-orphans \
  -v "$current_dir:$current_dir" \
  -it --rm -w $current_dir  gemini-cli sh /home/gemini-cli/bin/gemini_start.sh "$@"
