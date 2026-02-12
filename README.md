# 🔍 Nansen OpenClaw Skills

Blockchain analytics powered by [Nansen](https://nansen.ai) for [OpenClaw](https://openclaw.ai) agents. Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps — all through natural language.

## Skills

| Skill | Description |
|-------|-------------|
| [**nansen-core**](nansen-core/SKILL.md) | 🔑 Auth, setup, schema introspection — install first |
| [**nansen-smart-money**](nansen-smart-money/SKILL.md) | 🧠 Smart money flows, DEX trades, holdings, DCA strategies |
| [**nansen-profiler**](nansen-profiler/SKILL.md) | 🔎 Wallet profiling — balances, labels, PnL, counterparties |
| [**nansen-token**](nansen-token/SKILL.md) | 🪙 Token God Mode — holders, flows, screener, PnL leaderboards |
| [**nansen-portfolio**](nansen-portfolio/SKILL.md) | 📊 DeFi portfolio positions across protocols |
| [**nansen-hyperliquid**](nansen-hyperliquid/SKILL.md) | ⚡ Hyperliquid perpetual trading analytics |

## Quick Start

### 1. Install nansen-cli

```bash
npm install -g nansen-cli
```

Or run the setup script:

```bash
bash scripts/setup.sh
```

### 2. Authenticate

```bash
# Option A: Environment variable (recommended for agents)
export NANSEN_API_KEY=nsk_your_key_here

# Option B: Interactive login
nansen login
```

Get your API key at **[app.nansen.ai/api](https://app.nansen.ai/api)**.

### 3. Install Skills

Copy skill folders into your OpenClaw skills directory. **nansen-core** is required; add whichever domain skills you need.

### 4. Verify

```bash
nansen profiler search --query "Binance" --limit 1
```

## Supported Chains (20)

**Primary:** Ethereum · Solana · Base · Hyperliquid · BNB

**Also:** Arbitrum · Polygon · Optimism · Avalanche · Linea · Scroll · zkSync · Mantle · Ronin · Sei · Plasma · Sonic · Unichain · Monad · IOTA EVM

## Architecture

All skills wrap `nansen-cli` — no direct API calls. This gives you built-in caching, auto-retry with backoff, and schema introspection (`nansen schema`) for free.

```
nansen-core/SKILL.md          # Foundation (auth, global options, chains)
nansen-smart-money/SKILL.md   # smart-money namespace
nansen-profiler/SKILL.md      # profiler namespace
nansen-token/SKILL.md         # token namespace
nansen-portfolio/SKILL.md     # portfolio namespace
nansen-hyperliquid/SKILL.md   # Cross-namespace perp commands
scripts/setup.sh               # Install + auth verification
```

## Links

- [Nansen](https://nansen.ai) — Platform
- [Nansen API Docs](https://docs.nansen.ai) — API documentation
- [Get API Key](https://app.nansen.ai/api) — API key management
- [OpenClaw](https://openclaw.ai) — Agent platform

---

📊 Data by [Nansen](https://nansen.ai)
