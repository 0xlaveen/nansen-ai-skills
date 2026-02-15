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

## Command Routing

| User Intent | Command | Key Options | Status |
|------------|---------|-------------|--------|
| Token holdings | `profiler balance` | `--address` (req), `--chain`, `--entity` | ✅ |
| Wallet labels | `profiler labels` | `--address` (req), `--chain` | ✅ |
| Transactions | `profiler transactions` | `--address` (req), `--chain`, `--date` (req), `--limit` | ⚠️ needs `--date` |
| Historical balances | `profiler historical-balances` | `--address` (req), `--chain`, `--days` | ✅ |
| Counterparties | `profiler counterparties` | `--address` (req), `--chain`, `--days` | ✅ |
| Perp trades | `profiler perp-trades` | `--address` (req), `--days`, `--limit` | ✅ |
| PnL | `profiler pnl` | — | ⛔ Currently unavailable (404) |
| PnL summary | `profiler pnl-summary` | `--address` (req), `--chain`, `--days` | ⚠️ CLI bug (sends invalid field) |
| Entity search | `profiler search` | — | ⛔ Currently unavailable (404) |
| Related wallets | `profiler related-wallets` | `--address` (req), `--chain`, `--limit` | ⚠️ CLI bug (sends invalid field) |
| Perp positions | `profiler perp-positions` | `--address` (req), `--limit` | ⚠️ CLI bug (sends invalid field) |

### ⚠️ Known Issues

- **`profiler pnl`** and **`profiler search`** return 404 — do not use these commands.
- **`profiler transactions`** requires `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` (undocumented in schema). The `--days` option alone does NOT work.
- **`profiler related-wallets`**, **`profiler pnl-summary`** — CLI sends invalid `filters` field; may fail.
- **`profiler perp-positions`** — CLI sends invalid `pagination` field; may fail.

## Examples

```bash
# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort value_usd:desc --limit 20 --table

# Historical balances
nansen profiler historical-balances --address 0x... --chain ethereum --days 30 --table

# Counterparties
nansen profiler counterparties --address 0x... --chain ethereum --table

# Transactions (--date is required!)
nansen profiler transactions --address 0x... --chain ethereum --date '{"from": "2026-01-01", "to": "2026-02-15"}' --limit 20 --table
```

## Investigation Workflow

1. **Labels** → identity  2. **Balance** → current holdings  3. **Historical Balances** → trends  4. **Counterparties** → interactions

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
