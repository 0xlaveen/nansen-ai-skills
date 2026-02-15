# 🔍 Nansen AI Skills

Blockchain analytics powered by [Nansen](https://nansen.ai) for AI coding agents. Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps — all through natural language.

Supports **[OpenClaw](https://openclaw.ai)** and **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)**.

## Skills

| Skill | Description |
|-------|-------------|
| **nansen-router** | 🔀 Query entry point — routes to the right skill |
| **nansen-core** | 🔑 Auth, setup, schema introspection — install first |
| **nansen-smart-money** | 🧠 Smart money flows, DEX trades, holdings, DCA strategies |
| **nansen-profiler** | 🔎 Wallet profiling — balances, labels, PnL, counterparties |
| **nansen-token** | 🪙 Token God Mode — holders, flows, screener, PnL leaderboards |
| **nansen-portfolio** | 📊 DeFi portfolio positions across protocols |
| **nansen-hyperliquid** | ⚡ Hyperliquid perpetual trading analytics |

## Shared References

The `references/` directory contains detailed API documentation shared by both OpenClaw and Claude Code skills:

| File | Description |
|------|-------------|
| `references/schema.json` | Cached `nansen schema` output — source of truth for all commands |
| `references/commands.md` | Complete command reference with all parameters and return fields |
| `references/chains.md` | 18 supported chains with address formats |
| `references/smart-money-labels.md` | Smart money label definitions and filtering |
| `references/examples/` | Truncated JSON response examples for each domain |

## Get Started

### 1. Install nansen-cli

```bash
npm install -g nansen-cli
```

### 2. Set up your API key

1. Visit **[app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup)**
2. Sign in with your Nansen account
3. Copy the message shown
4. Paste it back to your agent

**Fallback options:**

```bash
export NANSEN_API_KEY=nsk_your_key_here   # Environment variable
nansen login                                # Interactive login
```

Get a key manually at **[app.nansen.ai/api](https://app.nansen.ai/api)**.

### 3. Verify

```bash
nansen profiler balance --address 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 --chain ethereum --limit 1
```

---

## Install for OpenClaw

Copy skill folders from `openclaw/` into your OpenClaw skills directory. **nansen-router** is the entry point; **nansen-core** is required for auth.

```
openclaw/
├── nansen-router/SKILL.md     ← entry point
├── nansen-core/SKILL.md
├── nansen-smart-money/SKILL.md
├── nansen-profiler/SKILL.md
├── nansen-token/SKILL.md
├── nansen-portfolio/SKILL.md
├── nansen-hyperliquid/SKILL.md
└── scripts/setup.sh
```

## Install for Claude Code

Copy `claude-code/CLAUDE.md` to your project root. The sub-files and `references/` directory provide detailed command guidance.

```
claude-code/
├── CLAUDE.md                  ← entry point
├── nansen-smart-money.md
├── nansen-profiler.md
├── nansen-token.md
├── nansen-portfolio.md
├── nansen-hyperliquid.md
└── scripts/setup.sh
```

---

## Supported Chains (18)

**Primary:** Ethereum · Solana · Base · HyperEVM · BNB

**Also:** Arbitrum · Polygon · Optimism · Avalanche · Linea · Scroll · Mantle · Ronin · Sei · Plasma · Sonic · Monad · IOTA EVM

## Architecture

All skills wrap `nansen-cli` — no direct API calls. This gives you built-in caching, auto-retry with backoff, and schema introspection (`nansen schema`) for free. The cached schema is stored at `references/schema.json` so agents don't need to run the command each time.

## Links

- [Nansen](https://nansen.ai) — Platform
- [Nansen API Docs](https://docs.nansen.ai) — API documentation
- [Get API Key](https://app.nansen.ai/api) — API key management
- [OpenClaw](https://openclaw.ai) — Agent platform
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — Anthropic's coding agent

---

📊 Data by [Nansen](https://nansen.ai)
