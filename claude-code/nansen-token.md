# Nansen Token — Token God Mode

Deep analytics for any token: holders, flows, trades, PnL, and discovery.

## ⚠️ Ticker Resolution First

Most commands need a contract address. If user gives a ticker:
```bash
nansen token screener --search <SYMBOL> --chain <chain>
# Copy FULL token_address from JSON (NOT --table)
```

## Commands

| Intent | Command | Key Options |
|--------|---------|-------------|
| Discover tokens | `nansen token screener` | `--chain`, `--timeframe`, `--smart-money`, `--limit`, `--sort` |
| Holder breakdown | `nansen token holders` | `--token` (req), `--chain`, `--smart-money`, `--limit` |
| Flow metrics | `nansen token flows` | `--token` (req), `--chain`, `--limit` |
| DEX trades | `nansen token dex-trades` | `--token` (req), `--chain`, `--smart-money`, `--days`, `--limit` |
| PnL leaderboard | `nansen token pnl` | `--token` (req), `--chain`, `--days`, `--limit`, `--sort` |
| Buyers/sellers | `nansen token who-bought-sold` | `--token` (req), `--chain`, `--limit` |
| Flow intelligence | `nansen token flow-intelligence` | `--token` (req), `--chain`, `--limit` |
| Transfers | `nansen token transfers` | `--token` (req), `--chain`, `--days`, `--limit` |
| Jupiter DCA | `nansen token jup-dca` | `--token` (req), `--limit` |

Perp commands use `--symbol`: see `nansen-hyperliquid.md`.

## Examples

```bash
# Screen by smart money on Ethereum
nansen token screener --chain ethereum --sort smart_money_count:desc --limit 20 --table

# WETH holders
nansen token holders --token 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 --chain ethereum --limit 20 --table

# Who's buying/selling?
nansen token who-bought-sold --token 0x... --chain ethereum --table

# PnL leaderboard
nansen token pnl --token 0x... --chain ethereum --sort realized_pnl:desc --limit 20 --table
```

## Discovery Workflow

1. **Screener** → find  2. **Holders** → who holds  3. **Who Bought/Sold** → activity  4. **Flow Intelligence** → labels  5. **PnL** → profits

## References

- Full parameters: `references/commands.md` (token section)
- Example response: `references/examples/token-holders.json`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
