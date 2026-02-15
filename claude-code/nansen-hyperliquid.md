# Nansen Hyperliquid — Perpetual Trading Analytics

Track smart money perpetual trading on Hyperliquid.

## Commands

| Intent | Command | Key Options |
|--------|---------|-------------|
| Smart money perp trades | `nansen smart-money perp-trades` | `--limit`, `--sort`, `--filters` *(no --chain)* |
| Perp trades by wallet | `nansen profiler perp-trades` | `--address` (req), `--days`, `--limit` |
| Perp positions by wallet | `nansen profiler perp-positions` | `--address` (req), `--limit` |
| Perp trades by symbol | `nansen token perp-trades` | `--symbol` (req), `--days`, `--limit` |
| Open positions by symbol | `nansen token perp-positions` | `--symbol` (req), `--limit` |
| PnL leaderboard | `nansen token perp-pnl-leaderboard` | `--symbol` (req), `--days`, `--limit` |

## Common Symbols

BTC, ETH, SOL, DOGE, ARB, OP, AVAX, LINK, UNI, AAVE, WIF, PEPE, JUP, TIA

## Examples

```bash
# Smart money trades now
nansen smart-money perp-trades --sort value_usd:desc --limit 20 --table

# BTC PnL leaderboard
nansen token perp-pnl-leaderboard --symbol BTC --sort total_pnl:desc --limit 20 --table

# SOL positions
nansen token perp-positions --symbol SOL --sort size_usd:desc --table

# Trader's positions
nansen profiler perp-positions --address 0x... --table
```

## Investigation Flow

1. `smart-money perp-trades` → what are best traders doing?
2. `token perp-pnl-leaderboard` → who's most profitable?
3. `profiler perp-positions` → drill into a trader
4. `token perp-positions` → overall market positioning

## References

- Full parameters: `references/commands.md` (perp commands across sections)
- Example response: `references/examples/smart-money-perp-trades.json`
- Labels: `references/smart-money-labels.md`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
