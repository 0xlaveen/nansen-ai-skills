---
name: nansen-profiler
description: >-
  Profile any wallet or entity on-chain via Nansen CLI. Look up balances, labels,
  transactions, PnL, related wallets, and counterparties.
metadata:
  clawdbot:
    emoji: "🔎"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and counterparties.

## When This Skill Activates

- "Who is this wallet?" / "What does 0x... hold?"
- "Show PnL for this address"
- "Transaction history" / "Related wallets" / "Counterparties"
- "Search for entity" / "Find wallet by name"

## Command Routing

| User Intent | Command | Key Options | Status |
|------------|---------|-------------|--------|
| Token holdings | `profiler balance` | `--address` (req), `--chain`, `--entity` | ✅ |
| Wallet labels | `profiler labels` | `--address` (req), `--chain` | ✅ |
| Transactions | `profiler transactions` | `--address` (req), `--chain`, `--date` (req), `--limit` | ⚠️ needs `--date` |
| Historical balances | `profiler historical-balances` | `--address` (req), `--chain`, `--days` | ✅ |
| Counterparties | `profiler counterparties` | `--address` (req), `--chain`, `--days` | ✅ |
| Related wallets | `profiler related-wallets` | `--address` (req), `--chain`, `--limit` | ✅ |
| PnL summary | `profiler pnl-summary` | `--address` (req), `--chain`, `--days` | ✅ |
| Perp trades | `profiler perp-trades` | `--address` (req), `--days`, `--limit` | ✅ |
| Perp positions | `profiler perp-positions` | `--address` (req) | ✅ (fixed: no --limit) |
| Entity search | `profiler search` | `--query` (req), `--limit` | ✅ |
| PnL | `profiler pnl` | — | ⛔ Currently unavailable (404) |

### ⚠️ Known Issues

- **`profiler pnl`** returns 404 — use `profiler pnl-summary` instead.
- **`profiler transactions`** requires `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` — the `--days` option alone does NOT work.

### Response Field Notes

- **`profiler labels`** returns: `label`, `category`, `definition`, `fullname`, `smEarnedDate` (not `label_type`/`label_subtype` as schema suggests)
- **`profiler historical-balances`** returns: `block_timestamp`, `chain`, `token_address`, `token_amount`, `token_symbol`, `value_usd` (not `date`/`balance`/`balance_usd`)
- **`profiler pnl-summary`** returns top-level fields: `top5_tokens`, `traded_token_count`, `traded_times`, `realized_pnl_usd`, `realized_pnl_percent`, `win_rate`

## Examples

```bash
# Search for an entity by name
nansen profiler search --query "Vitalik"
nansen profiler search --query "Binance"

# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort value_usd:desc --limit 20 --table

# Historical balances
nansen profiler historical-balances --address 0x... --chain ethereum --days 30 --table

# Counterparties
nansen profiler counterparties --address 0x... --chain ethereum --table

# Related wallets
nansen profiler related-wallets --address 0x... --chain ethereum --limit 10 --table

# PnL summary
nansen profiler pnl-summary --address 0x... --chain ethereum --days 30

# Transactions (--date is required!)
nansen profiler transactions --address 0x... --chain ethereum --date '{"from": "2026-01-01", "to": "2026-02-15"}' --limit 20 --table

# Perp positions (no --limit supported)
nansen profiler perp-positions --address 0x...
```

## Investigation Workflow

1. **Search** → find entity  2. **Labels** → identity  3. **Balance** → current holdings  4. **Historical Balances** → trends  5. **Counterparties** → interactions

## Ticker Resolution

If user gives a ticker instead of address:
```bash
nansen token screener --search PENGU --chain solana  # → get full token_address from JSON
```

## References

- Command parameters: `references/commands.md` (profiler section)
- Example response: `references/examples/profiler-balance.json`
- Cached schema: `references/schema.json`

## Attribution

> 📊 Data by [Nansen](https://nansen.ai)
