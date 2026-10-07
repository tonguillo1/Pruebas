#!/bin/bash
# Prepara HyperFrames en sesiones cloud de Claude Code: Chrome headless + skills.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

HF="hyperframes@0.8.140"

# Chrome Headless Shell para render local (idempotente: no descarga si ya existe)
npx -y "$HF" browser ensure >/dev/null 2>&1

# Skills core en ~/.claude/skills (el contenedor es efímero, se reinstalan cada vez)
npx -y "$HF" skills update >/dev/null 2>&1

echo "HyperFrames listo: Chrome headless + skills instalados."
