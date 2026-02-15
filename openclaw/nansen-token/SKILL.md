---
name: nansen-token
description: >-
  Token God Mode analytics via Nansen CLI. Screen tokens, analyze holders, track
  flows, see who's buying/selling, PnL leaderboards, and flow intelligence by label.
metadata:
  clawdbot:
    emoji: "🪙"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Token — Token God Mode

Deep analytics for any token: holders, flows, trades, PnL, and discovery.

## When This Skill Activates

- "Who holds $TOKEN?" / "Top holders"
- "Screen tokens by smart money"
- "Token flows" / "Who's buying/selling?"
- "PnL leaderboard for $TOKEN"

## ⚠️ Token Address Resolution

Most commands need a contract address. If user gives a ticker:
```bash
nansen token screener --search <SYMBOL> --chain <chain>
# Copy FULL token_address from JSON output (NOT --table)
```

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Discover tokens | `token screener` | `--chain`, `--timeframe`, `--smart-money`, `--limit`, `--sort` |
| Holder breakdown | `token holders` | `--token` (req), `--chain`, `--smart-money`, `--limit` |
| Flow metrics | `token flows` | `--token` (req), `--chain`, `--limit` |
| DEX trades | `token dex-trades` | `--token` (req), `--chain`, `--smart-money`, `--days`, `--limit` |
| PnL leaderboard | `token pnl` | `--token` (req), `--chain`, `--days`, `--limit`, `--sort` |
| Buyers/sellers | `token who-bought-sold` | `--token` (req), `--chain`, `--limit` |
| Flow intelligence | `token flow-intelligence` | `--token` (req), `--chain`, `--limit` |
| Transfers | `token transfers` | `--token` (req), `--chain`, `--days`, `--limit` |
| Jupiter DCA | `token jup-dca` | `--token` (req), `--limit` |

> Perp commands (`perp-trades`, `perp-positions`, `perp-pnl-leaderboard`) use `--symbol` instead of `--token`. See **nansen-hyperliquid**.

## Examples

```bash
# Screen tokens on Ethereum by smart money
nansen token screener --chain ethereum --sort smart_money_count:desc --limit 20 --table

# Top WETH holders
nansen token holders --token 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 --chain ethereum --limit 20 --table

# Who's buying/selling?
nansen token who-bought-sold --token 0x... --chain ethereum --table

# PnL leaderboard
nansen token pnl --token 0x... --chain ethereum --sort realized_pnl:desc --limit 20 --table
```

## Discovery Workflow

1. **Screener** → find tokens  2. **Holders** → who holds?  3. **Who Bought/Sold** → activity  4. **Flow Intelligence** → label breakdown  5. **PnL** → profits  6. **Flows** → net movement

## References

- Command parameters: `references/commands.md` (token section)
- Example response: `references/examples/token-holders.json`
- Cached schema: `references/schema.json`

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
