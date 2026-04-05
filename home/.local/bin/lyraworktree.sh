#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: lyraworktree.sh <name>" >&2
  exit 1
fi

name="$1"
repo="$HOME/IdeaProjects/lyra"
worktree_path="$HOME/IdeaProjects/lyra-${name}"

git -C "$repo" worktree add -b "$name" "$worktree_path" main

mkdir -p "$worktree_path/.idea/runConfigurations"
cp "$repo/.idea/runConfigurations/"* "$worktree_path/.idea/runConfigurations/"
echo "Copied IntelliJ run configurations"

local_props=(
  "application.yaml"
  "lyra-app/src/integrationTest/resources/application-integration-local.yaml"
  "pah-app/src/integrationTest/resources/application-integration-local.yaml"
)
for prop in "${local_props[@]}"; do
  if [ -f "$repo/$prop" ]; then
    ln -s "$repo/$prop" "$worktree_path/$prop"
  fi
done
echo "Symlinked application properties"

echo "Worktree created at $worktree_path on branch $name"
