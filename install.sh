#!/usr/bin/env bash
# claude-config-team 설치 스크립트 (macOS / Linux)
# skills/ -> ~/.claude/skills/, agents/ -> ~/.claude/agents/ 복사

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
AGENTS_DIR="$HOME/.claude/agents"

mkdir -p "$SKILLS_DIR" "$AGENTS_DIR"

for skill in "$REPO_ROOT"/skills/*/; do
  name="$(basename "$skill")"
  [ -d "$SKILLS_DIR/$name" ] && echo "덮어쓰기: $name"
  cp -R "$skill" "$SKILLS_DIR/"
  echo "스킬 설치: $name"
done

for agent in "$REPO_ROOT"/agents/*.md; do
  cp "$agent" "$AGENTS_DIR/"
  echo "에이전트 설치: $(basename "$agent" .md)"
done

echo ""
echo "설치 완료. ~/.claude/CLAUDE.md에 슬래시 커맨드 등록 스니펫을 추가하세요 (README 참고)."
