#!/usr/bin/env bash
# Nansen CLI Setup Script for OpenClaw & Claude Code
# Installs nansen-cli and verifies authentication
set -euo pipefail

BOLD='\033[1m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${BOLD}🔍 Nansen CLI Setup${NC}\n"

# 1. Check Node.js
if ! command -v node &>/dev/null; then
  echo -e "${RED}✗ Node.js not found.${NC} Install from https://nodejs.org (v18+ required)"
  exit 1
fi
echo -e "${GREEN}✓${NC} Node.js $(node --version)"

# 2. Check/install nansen-cli
if command -v nansen &>/dev/null; then
  echo -e "${GREEN}✓${NC} nansen-cli installed ($(nansen --version 2>/dev/null || echo 'unknown version'))"
else
  echo -e "${YELLOW}→ Installing nansen-cli...${NC}"
  npm install -g nansen-cli
  if command -v nansen &>/dev/null; then
    echo -e "${GREEN}✓${NC} nansen-cli installed successfully"
  else
    echo -e "${RED}✗ Installation failed.${NC} Try: sudo npm install -g nansen-cli"
    exit 1
  fi
fi

# 3. Check authentication
echo -e "\n${BOLD}Checking authentication...${NC}"
if nansen profiler search --query "Binance" --limit 1 &>/dev/null; then
  echo -e "${GREEN}✓${NC} Authenticated and working!"
  echo -e "\n${GREEN}All set! Nansen skills are ready to use.${NC}"
  exit 0
fi

# Not authenticated
echo -e "${YELLOW}✗ Not authenticated${NC}\n"
echo -e "To authenticate, choose one option:\n"
echo -e "  ${BOLD}Option A${NC} — Environment variable (recommended for agents):"
echo -e "    export NANSEN_API_KEY=nsk_your_key_here\n"
echo -e "  ${BOLD}Option B${NC} — Interactive login:"
echo -e "    nansen login\n"
echo -e "Get your API key at: ${BOLD}https://app.nansen.ai/api${NC}"
exit 1
