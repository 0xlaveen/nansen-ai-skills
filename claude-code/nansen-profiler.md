# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and counterparties.

## Commands

| Intent | Command | Key Options | Status |
|--------|---------|-------------|--------|
| Token holdings | `nansen profiler balance` | `--address` (req), `--chain`, `--entity` | ✅ |
| Labels | `nansen profiler labels` | `--address` (req), `--chain` | ✅ |
| Transactions | `nansen profiler transactions` | `--address` (req), `--chain`, `--date` (req), `--limit` | ⚠️ needs `--date` |
| Historical balances | `nansen profiler historical-balances` | `--address` (req), `--chain`, `--days` | ✅ |
| Counterparties | `nansen profiler counterparties` | `--address` (req), `--chain`, `--days` | ✅ |
| Perp trades | `nansen profiler perp-trades` | `--address` (req), `--days`, `--limit` | ✅ |
| PnL | `nansen profiler pnl` | — | ⛔ Unavailable (404) |
| PnL summary | `nansen profiler pnl-summary` | `--address` (req), `--chain`, `--days` | ⚠️ CLI bug |
| Entity search | `nansen profiler search` | — | ⛔ Unavailable (404) |
| Related wallets | `nansen profiler related-wallets` | `--address` (req), `--chain`, `--limit` | ⚠️ CLI bug |
| Perp positions | `nansen profiler perp-positions` | `--address` (req), `--limit` | ⚠️ CLI bug |

### ⚠️ Known Issues

- **`profiler pnl`** and **`profiler search`** return 404 — do not use.
- **`profiler transactions`** requires `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` (undocumented). `--days` alone does NOT work.
- **`profiler related-wallets`**, **`profiler pnl-summary`** — CLI sends invalid `filters` field.
- **`profiler perp-positions`** — CLI sends invalid `pagination` field.

## Examples

```bash
# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort value_usd:desc --limit 20 --table

# Counterparties
nansen profiler counterparties --address 0x... --chain ethereum --table

# Transactions (--date is required!)
nansen profiler transactions --address 0x... --chain ethereum --date '{"from": "2026-01-01", "to": "2026-02-15"}' --limit 20 --table
```

## Investigation Workflow

1. **Labels** → identity  2. **Balance** → holdings  3. **Historical Balances** → trends  4. **Counterparties** → interactions

## Ticker Resolution

User gives ticker? Resolve first: `nansen token screener --search PENGU --chain solana` → copy full address from JSON.

## References

- Full parameters: `references/commands.md` (profiler section)
- Example response: `references/examples/profiler-balance.json`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
