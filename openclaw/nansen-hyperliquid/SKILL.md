---
name: nansen-hyperliquid
description: >-
  Hyperliquid perpetual trading analytics via Nansen CLI. Track smart money perp
  trades, open positions, PnL leaderboards, and trader analysis on Hyperliquid.
  Use when the user asks about Hyperliquid perps, perpetual futures, leveraged
  trading, or smart money activity on Hyperliquid specifically.
metadata:
  clawdbot:
    emoji: "⚡"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Hyperliquid — Perpetual Trading Analytics

Track smart money perpetual trading on Hyperliquid.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters.
3. **Use JSON for data extraction, `--table` only for final display.**

## When This Skill Activates

- "What are smart money trading on Hyperliquid?"
- "Hyperliquid perp trades"
- "Open positions on Hyperliquid"
- "PnL leaderboard for Hyperliquid perps"
- "Perp trades for $BTC / $ETH on Hyperliquid"
- "Who's long/short on Hyperliquid?"
- "Smart HL perps traders"
- Any mention of Hyperliquid + trading/perps/positions

## Prerequisites

Requires **nansen-core** skill for auth. Verify with: `nansen schema`

## Command Routing

Hyperliquid data is accessed through perp-specific subcommands across three CLI namespaces:

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Smart money perp trades | `nansen smart-money perp-trades` | `--limit`, `--sort value_usd:desc` |
| Perp trades by wallet | `nansen profiler perp-trades` | `--address`, `--limit` |
| Current perp positions by wallet | `nansen profiler perp-positions` | `--address` |
| Perp trades by token/symbol | `nansen token perp-trades` | `--symbol` |
| Open positions by token | `nansen token perp-positions` | `--symbol`, `--sort size_usd:desc` |
| Perp PnL leaderboard by token | `nansen token perp-pnl-leaderboard` | `--symbol`, `--sort total_pnl_usd:desc` |

> **Tip:** Run `nansen schema` to see exact options. For chain-specific queries, use `--chain hyperevm`. Perp-specific subcommands (perp-trades, perp-positions, perp-pnl-leaderboard) target Hyperliquid automatically.

## Common Perp Symbols

| Symbol | Asset | | Symbol | Asset |
|--------|-------|-|--------|-------|
| `BTC` | Bitcoin | | `LINK` | Chainlink |
| `ETH` | Ethereum | | `UNI` | Uniswap |
| `SOL` | Solana | | `AAVE` | Aave |
| `DOGE` | Dogecoin | | `WIF` | dogwifhat |
| `ARB` | Arbitrum | | `PEPE` | Pepe |
| `OP` | Optimism | | `JUP` | Jupiter |
| `AVAX` | Avalanche | | `TIA` | Celestia |
| `MATIC` | Polygon | | | |

## Smart Money Labels (Hyperliquid)

| Label | Description |
|-------|-------------|
| `Smart HL Perps Trader` | Consistently profitable on HL perps |
| `Fund` | Institutional fund wallets |
| `Smart Trader` | All-time profitable traders |

## Example Queries → Commands

### "What are smart money trading on Hyperliquid right now?"
```bash
nansen smart-money perp-trades --sort value_usd:desc --limit 20 --table
```

### "Top Hyperliquid PnL leaderboard for BTC perps"
```bash
nansen token perp-pnl-leaderboard --symbol BTC --sort total_pnl:desc --limit 20 --table
```

### "Open positions for BTC perps"
```bash
nansen token perp-positions --symbol BTC --sort size_usd:desc --table
```

### "Perp trades for ETH"
```bash
nansen token perp-trades --symbol ETH --limit 30 --table
```

### "What perp positions does this trader hold?"
```bash
nansen profiler perp-positions --address 0x... --table
```

### "This trader's perp trade history"
```bash
nansen profiler perp-trades --address 0x... --limit 50 --table
```

### "What's the smart money sentiment on SOL?"
```bash
# 1. Recent perp trades — count longs vs shorts
nansen smart-money perp-trades --limit 50

# 2. Open positions — overall market positioning
nansen token perp-positions --symbol SOL --sort size_usd:desc --limit 20
```
Analyze: long/short ratio, total open interest, largest positions.

## Hyperliquid Investigation Workflow

1. **Smart money perp trades** — What are the best traders doing right now?
2. **Perp PnL leaderboard** — Who's most profitable on a specific asset?
3. **Profiler perp-positions** — Drill into a specific trader's current positions
4. **Profiler perp-trades** — See their trade history
5. **Token perp-positions** — Overall market positioning on an asset

## Output Formatting

- Use `--table` for display
- For perp trades, highlight: symbol, side (long/short), size, entry price, PnL
- For positions, show: symbol, side, size, unrealized PnL, leverage if available
- For leaderboards, rank by total PnL with win rate if available

## Scope Note

This skill covers Hyperliquid analytics via `nansen-cli` commands only. It does not wrap the Hyperliquid API directly — all data flows through Nansen's enriched analytics layer, which adds smart money labels, entity identification, and cross-chain context.


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set `NANSEN_API_KEY` env var or run `nansen login`. Get a key at [app.nansen.ai/api](https://app.nansen.ai/api).
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
