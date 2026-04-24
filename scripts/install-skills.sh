#!/usr/bin/env sh

set -eu

REPO_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
TARGET_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"

mkdir -p "$TARGET_DIR"

for legacy_name in git-conventional-commits-pt-br; do
  legacy_path="$TARGET_DIR/$legacy_name"

  if [ -L "$legacy_path" ]; then
    rm "$legacy_path"
    printf 'removido alias antigo: %s\n' "$legacy_path"
  fi
done

installed_count=0

for skill_file in "$REPO_DIR"/*/SKILL.md; do
  [ -e "$skill_file" ] || continue

  skill_dir="$(dirname -- "$skill_file")"
  skill_name="$(basename -- "$skill_dir")"
  target_path="$TARGET_DIR/$skill_name"

  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    printf 'erro: %s ja existe e nao e um symlink\n' "$target_path" >&2
    printf 'remova ou renomeie esse caminho antes de instalar a skill %s\n' "$skill_name" >&2
    exit 1
  fi

  ln -sfn "$skill_dir" "$target_path"
  installed_count=$((installed_count + 1))
  printf 'instalada: %s -> %s\n' "$skill_name" "$target_path"
done

if [ "$installed_count" -eq 0 ]; then
  printf 'nenhuma skill encontrada em %s\n' "$REPO_DIR" >&2
  exit 1
fi

printf 'total instalado: %s skill(s)\n' "$installed_count"
