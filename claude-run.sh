#!/bin/sh

set -e
current_dir=$(realpath $(pwd))
script_dir=$(dirname $(realpath $0))

# Создаем директорию для пользовательских модулей, если её нет
mkdir -p $script_dir/home/node_modules

claudePath=/usr/local/bin/claude

if [ -f $script_dir/home/.claude/local/claude ]; then
    claudePath=/home/claude-code/.claude/local/claude
    echo "Claude Code is local. Using $claudePath"
fi

docker compose -f $script_dir/docker-compose.yml run --remove-orphans \
  -v "$current_dir:$current_dir" \
  -it --rm -w $current_dir claude-code $claudePath "$@"
