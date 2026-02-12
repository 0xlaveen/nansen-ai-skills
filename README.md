# 🔍 Nansen AI Skills

Blockchain analytics powered by [Nansen](https://nansen.ai) for AI coding agents. Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps — all through natural language.

Supports **[OpenClaw](https://openclaw.ai)** and **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)**.

## Skills

| Skill | Description |
|-------|-------------|
| **nansen-core** | 🔑 Auth, setup, schema introspection — install first |
| **nansen-smart-money** | 🧠 Smart money flows, DEX trades, holdings, DCA strategies |
| **nansen-profiler** | 🔎 Wallet profiling — balances, labels, PnL, counterparties |
| **nansen-token** | 🪙 Token God Mode — holders, flows, screener, PnL leaderboards |
| **nansen-portfolio** | 📊 DeFi portfolio positions across protocols |
| **nansen-hyperliquid** | ⚡ Hyperliquid perpetual trading analytics |

## Quick Start

### 1. Install nansen-cli

```bash
npm install -g nansen-cli
```

Or run the setup script:

```bash
bash openclaw/scripts/setup.sh
# or
bash claude-code/scripts/setup.sh
```

### 2. Authenticate

```bash
# Option A: Environment variable (recommended for agents)
export NANSEN_API_KEY=nsk_your_key_here

# Option B: Interactive login
nansen login
```

Get your API key at **[app.nansen.ai/api](https://app.nansen.ai/api)**.

### 3. Verify

```bash
nansen profiler search --query "Binance" --limit 1
```

---

## Install for OpenClaw

Copy skill folders from `openclaw/` into your OpenClaw skills directory. **nansen-core** is required; add whichever domain skills you need.

```
openclaw/
├── nansen-core/SKILL.md
├── nansen-smart-money/SKILL.md
├── nansen-profiler/SKILL.md
├── nansen-token/SKILL.md
├── nansen-portfolio/SKILL.md
├── nansen-hyperliquid/SKILL.md
└── scripts/setup.sh
```

## Install for Claude Code

Copy `claude-code/CLAUDE.md` to your project root (or reference it in your Claude Code config). The sub-files provide detailed command guidance per domain.

```
claude-code/
├── CLAUDE.md                  # Entry point — Claude Code reads this
├── nansen-smart-money.md
├── nansen-profiler.md
├── nansen-token.md
├── nansen-portfolio.md
├── nansen-hyperliquid.md
└── scripts/setup.sh
```

---

## Supported Chains (20)

**Primary:** Ethereum · Solana · Base · Hyperliquid · BNB

**Also:** Arbitrum · Polygon · Optimism · Avalanche · Linea · Scroll · zkSync · Mantle · Ronin · Sei · Plasma · Sonic · Unichain · Monad · IOTA EVM

## Architecture

All skills wrap `nansen-cli` — no direct API calls. This gives you built-in caching, auto-retry with backoff, and schema introspection (`nansen schema`) for free.

## Links

- [Nansen](https://nansen.ai) — Platform
- [Nansen API Docs](https://docs.nansen.ai) — API documentation
- [Get API Key](https://app.nansen.ai/api) — API key management
- [OpenClaw](https://openclaw.ai) — Agent platform
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — Anthropic's coding agent

---

📊 Data by [Nansen](https://nansen.ai)
