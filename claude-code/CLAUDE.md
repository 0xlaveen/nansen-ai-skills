# Nansen AI Skills — Claude Code

Blockchain analytics powered by [Nansen](https://nansen.ai). Track smart money flows, profile wallets, analyze tokens, and monitor Hyperliquid perps through the `nansen` CLI.

## Setup

### Install nansen-cli

```bash
npm install -g nansen-cli
```

Or run the setup script:

```bash
bash claude-code/scripts/setup.sh
```

### Authenticate

```bash
# Option A: Environment variable (recommended)
export NANSEN_API_KEY=nsk_your_key_here

# Option B: Interactive login
nansen login
```

Get your API key at **[app.nansen.ai/api](https://app.nansen.ai/api)**.

### Verify

```bash
nansen profiler search --query "Binance" --limit 1
```

## Tools

Allowed command patterns:

- `nansen *` — all nansen CLI commands

## Schema Introspection

Run `nansen schema` to discover all commands, options, and return fields. Use it liberally — it's local and fast.

## Global Options

| Option | Purpose | Example |
|--------|---------|---------|
| `--table` | Tabular output for display | `nansen smart-money netflow --table` |
| `--fields` | Select specific columns | `--fields token_symbol,net_flow_usd` |
| `--chain` | Filter by blockchain | `--chain ethereum` |
| `--chains` | Multiple chains | `--chains ethereum,solana` |
| `--limit` | Max results | `--limit 20` |
| `--sort` | Sort field + direction | `--sort net_flow_usd:desc` |
| `--days` | Date range (days back) | `--days 7` |
| `--filters` | Advanced JSON filter | `--filters '{"min_usd": 10000}'` |
| `--pretty` | Pretty-print JSON | |
| `--no-cache` | Skip cache | |

## Supported Chains (20)

**Primary:** ethereum · solana · base · hyperliquid · bnb

**All:** ethereum, solana, base, bnb, arbitrum, polygon, optimism, avalanche, linea, scroll, zksync, mantle, ronin, sei, plasma, sonic, unichain, monad, hyperevm, iotaevm

## Skill Reference Files

Each file below contains detailed command routing, examples, and interpretation guidance:

| File | Domain |
|------|--------|
| [nansen-smart-money.md](nansen-smart-money.md) | 🧠 Smart money flows, DEX trades, holdings, DCA strategies |
| [nansen-profiler.md](nansen-profiler.md) | 🔎 Wallet profiling — balances, labels, PnL, counterparties |
| [nansen-token.md](nansen-token.md) | 🪙 Token God Mode — holders, flows, screener, PnL leaderboards |
| [nansen-portfolio.md](nansen-portfolio.md) | 📊 DeFi portfolio positions across protocols |
| [nansen-hyperliquid.md](nansen-hyperliquid.md) | ⚡ Hyperliquid perpetual trading analytics |

## Error Handling

| Error | Fix |
|-------|-----|
| "API key required" | Set `NANSEN_API_KEY` or run `nansen login` |
| "Invalid API key" | Get new key at app.nansen.ai/api |
| "Rate limited" | CLI auto-retries; wait if persistent |
| "Chain not supported" | Check supported chains list above |
| Command not found | `npm install -g nansen-cli` |

## Attribution

All outputs using Nansen data must include:
> 📊 Data by [Nansen](https://nansen.ai)
