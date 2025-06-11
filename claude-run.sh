#!/bin/sh

current_dir=$(realpath $(pwd))
script_dir=$(dirname $(realpath $0))


docker compose -f $script_dir/docker-compose.yml run  -v $current_dir:$current_dir -it --rm -w $current_dir claude-code claude  "$@"
