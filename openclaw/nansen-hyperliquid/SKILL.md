---
name: nansen-hyperliquid
description: >-
  Hyperliquid perpetual trading analytics via Nansen CLI. Track smart money perp
  trades, open positions, PnL leaderboards, and trader analysis on Hyperliquid.
metadata:
  clawdbot:
    emoji: "⚡"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Hyperliquid — Perpetual Trading Analytics

Track smart money perpetual trading on Hyperliquid.

## When This Skill Activates

- "What are smart money trading on Hyperliquid?"
- "Perp trades / positions / PnL leaderboard"
- "Who's long/short on BTC/ETH/SOL?"
- Any mention of Hyperliquid + trading/perps

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Smart money perp trades | `smart-money perp-trades` | `--limit`, `--sort`, `--filters` *(no --chain)* |
| Perp trades by wallet | `profiler perp-trades` | `--address` (req), `--days`, `--limit` |
| Perp positions by wallet | `profiler perp-positions` | `--address` (req), `--limit` |
| Perp trades by symbol | `token perp-trades` | `--symbol` (req), `--days`, `--limit` |
| Open positions by symbol | `token perp-positions` | `--symbol` (req), `--limit` |
| PnL leaderboard | `token perp-pnl-leaderboard` | `--symbol` (req), `--days`, `--limit` |

## Common Symbols

BTC, ETH, SOL, DOGE, ARB, OP, AVAX, MATIC, LINK, UNI, AAVE, WIF, PEPE, JUP, TIA

## Examples

```bash
# Smart money trades right now
nansen smart-money perp-trades --sort value_usd:desc --limit 20 --table

# BTC PnL leaderboard
nansen token perp-pnl-leaderboard --symbol BTC --sort total_pnl:desc --limit 20 --table

# Open positions for SOL
nansen token perp-positions --symbol SOL --sort size_usd:desc --table

# Trader's positions
nansen profiler perp-positions --address 0x... --table
```

## Investigation Flow

1. `smart-money perp-trades` → what are best traders doing?
2. `token perp-pnl-leaderboard` → who's most profitable?
3. `profiler perp-positions` → drill into a trader
4. `token perp-positions` → market positioning on an asset

## References

- Command parameters: `references/commands.md` (perp commands in smart-money, profiler, token sections)
- Example response: `references/examples/smart-money-perp-trades.json`
- Smart money labels: `references/smart-money-labels.md`
- Cached schema: `references/schema.json`

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
