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
nansen token perp-pnl-leaderboard --symbol BTC --sort pnl_usd_total:desc --limit 20 --table

# Open positions for SOL
nansen token perp-positions --symbol SOL --sort position_value_usd:desc --table

# Trader's positions
nansen profiler perp-positions --address 0x... --table
```

## API-Only Endpoints (Not in CLI)

These Hyperliquid endpoints exist in the Nansen API but have **no CLI command yet**:

- **Perp Screener** (`/api/v1/perp-screener`) — Screen perp contracts by volume, OI, funding, smart money activity
- **Perp Leaderboard** (`/api/v1/perp-leaderboard`) — Global Hyperliquid trader leaderboard by PnL/ROI over a date range

### Direct API Examples

```bash
# Perp Leaderboard — top traders by PnL over a date range
curl -s -X POST -H "apikey: $NANSEN_API_KEY" -H "Content-Type: application/json" \
  -d '{"date":{"from":"2026-02-01","to":"2026-02-15"}}' \
  "https://api.nansen.ai/api/v1/perp-leaderboard"
# Returns: trader_address, trader_address_label, total_pnl, roi, account_value

# Perp Screener — screen perp contracts by volume, OI, funding
curl -s -X POST -H "apikey: $NANSEN_API_KEY" -H "Content-Type: application/json" \
  -d '{"date":{"from":"2026-02-01","to":"2026-02-15"}}' \
  "https://api.nansen.ai/api/v1/perp-screener"
# Returns: token_symbol, volume, buy_volume, sell_volume, buy_sell_pressure, trader_count, mark_price, funding, open_interest
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
