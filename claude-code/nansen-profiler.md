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
| Related wallets | `nansen profiler related-wallets` | `--address` (req), `--chain`, `--limit` | ✅ |
| PnL summary | `nansen profiler pnl-summary` | `--address` (req), `--chain`, `--days` | ✅ |
| Perp trades | `nansen profiler perp-trades` | `--address` (req), `--days`, `--limit` | ✅ |
| Perp positions | `nansen profiler perp-positions` | `--address` (req) | ✅ |
| Entity search | `nansen profiler search` | `--query` (req), `--limit` | ✅ |
| Batch profile | `nansen profiler batch` | `--addresses` or `--file` (req), `--chain`, `--include` | ✅ |
| Trace | `nansen profiler trace` | `--address` (req), `--chain`, `--depth`, `--width` | ✅ |
| Compare wallets | `nansen profiler compare` | `--addresses` (req), `--chain`, `--days` | ✅ |
| PnL | `nansen profiler pnl` | — | ⛔ Unavailable (404) |

### ⚠️ Known Issues

- **`profiler pnl`** returns 404 — use `profiler pnl-summary` instead.
- **`profiler transactions`** requires `--date '{"from": "YYYY-MM-DD", "to": "YYYY-MM-DD"}'` — the `--days` option alone does NOT work.

## Examples

```bash
# Search for an entity by name
nansen profiler search --query "Vitalik"

# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort value_usd:desc --limit 20 --table

# Related wallets
nansen profiler related-wallets --address 0x... --chain ethereum --limit 10 --table

# Counterparties
nansen profiler counterparties --address 0x... --chain ethereum --table

# PnL summary
nansen profiler pnl-summary --address 0x... --chain ethereum --days 30

# Transactions (--date is required!)
nansen profiler transactions --address 0x... --chain ethereum --date '{"from": "2026-01-01", "to": "2026-02-15"}' --limit 20 --table

# Batch profile multiple wallets
nansen profiler batch --addresses "0xabc...,0xdef..." --chain ethereum --include labels,balance

# Trace counterparty network (BFS)
nansen profiler trace --address 0x... --chain ethereum --depth 2 --width 10

# Compare two wallets
nansen profiler compare --addresses "0xabc...,0xdef..." --chain ethereum
```

## Investigation Workflow

1. **Search** → find entity  2. **Labels** → identity  3. **Balance** → holdings  4. **Historical Balances** → trends  5. **Counterparties** → interactions  6. **Trace** → network mapping

## Ticker Resolution

User gives ticker? Resolve first: `nansen token screener --search PENGU --chain solana` → copy full address from JSON.

## References

- Full parameters: `references/commands.md` (profiler section)
- Example response: `references/examples/profiler-balance.json`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
