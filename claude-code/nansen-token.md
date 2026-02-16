# Nansen Token — Token God Mode

Deep analytics for any token: holders, flows, trades, PnL, and discovery.

## ⚠️ Ticker Resolution First

Most commands need a contract address. If user gives a ticker:
```bash
nansen token screener --search <SYMBOL> --chain <chain>
# Copy FULL token_address from JSON (NOT --table)
```

## Commands

| Intent | Command | Key Options | Status |
|--------|---------|-------------|--------|
| Discover tokens | `nansen token screener` | `--chain`, `--timeframe`, `--smart-money`, `--limit`, `--sort` | ✅ |
| Holder breakdown | `nansen token holders` | `--token` (req), `--chain`, `--smart-money`, `--limit` | ✅ |
| DEX trades | `nansen token dex-trades` | `--token` (req), `--chain`, `--smart-money`, `--days`, `--limit` | ✅ |
| PnL leaderboard | `nansen token pnl` | `--token` (req), `--chain`, `--days`, `--limit`, `--sort` | ✅ |
| Transfers | `nansen token transfers` | `--token` (req), `--chain`, `--days`, `--limit`, `--from`, `--to` | ✅ |
| Flow metrics | `nansen token flows` | `--token` (req), `--chain`, `--date` (req) | ⚠️ needs `--date` |
| Buyers/sellers | `nansen token who-bought-sold` | `--token` (req), `--chain`, `--date` (req) | ⚠️ needs `--date` |
| Flow intelligence | `nansen token flow-intelligence` | `--token` (req), `--chain`, `--days` | ✅ |
| Jupiter DCA | `nansen token jup-dca` | `--token` (req), `--limit` | ✅ (Solana only) |

Perp commands use `--symbol`: see `nansen-hyperliquid.md`.

### ⚠️ Known Issues

- **`token flows`** and **`token who-bought-sold`** require `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` — without it, the API returns an error.
- **`token jup-dca`** — Solana only. Use a non-native Solana token address (e.g., JUP, BONK). Native tokens like wSOL are rejected by the API.

## Examples

```bash
# Screen by smart money on Ethereum
nansen token screener --chain ethereum --sort smart_money_count:desc --limit 20 --table

# WETH holders
nansen token holders --token 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 --chain ethereum --limit 20 --table

# Token flows (--date required!)
nansen token flows --token 0x... --chain ethereum --date '{"from": "2026-02-01", "to": "2026-02-15"}' --table

# PnL leaderboard
nansen token pnl --token 0x... --chain ethereum --sort pnl_usd_realised:desc --limit 20 --table
```

## Discovery Workflow

1. **Screener** → find  2. **Holders** → who holds  3. **DEX Trades** → activity  4. **PnL** → profits

## References

- Full parameters: `references/commands.md` (token section)
- Example response: `references/examples/token-holders.json`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
