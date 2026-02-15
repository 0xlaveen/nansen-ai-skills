# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and entity search.

## Commands

| Intent | Command | Key Options |
|--------|---------|-------------|
| Token holdings | `nansen profiler balance` | `--address` (req), `--chain`, `--entity` |
| Labels | `nansen profiler labels` | `--address` (req), `--chain` |
| Transactions | `nansen profiler transactions` | `--address` (req), `--chain`, `--limit`, `--days` |
| PnL | `nansen profiler pnl` | `--address` (req), `--chain` |
| PnL summary | `nansen profiler pnl-summary` | `--address` (req), `--chain`, `--days` |
| Entity search | `nansen profiler search` | `--query` (req), `--limit` |
| Historical balances | `nansen profiler historical-balances` | `--address` (req), `--chain`, `--days` |
| Related wallets | `nansen profiler related-wallets` | `--address` (req), `--chain`, `--limit` |
| Counterparties | `nansen profiler counterparties` | `--address` (req), `--chain`, `--days` |
| Perp positions | `nansen profiler perp-positions` | `--address` (req), `--limit` |
| Perp trades | `nansen profiler perp-trades` | `--address` (req), `--days`, `--limit` |

## Examples

```bash
# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort balance_usd:desc --limit 20 --table

# PnL
nansen profiler pnl --address 0x... --chain ethereum --table

# Search entity
nansen profiler search --query Wintermute --limit 10 --table

# Related wallets
nansen profiler related-wallets --address 0x... --table
```

## Investigation Workflow

1. **Labels** → identity  2. **Balance** → holdings  3. **PnL Summary** → profitability  4. **Counterparties** → interactions  5. **Related Wallets** → linked addresses

## Ticker Resolution

User gives ticker? Resolve first: `nansen token screener --search PENGU --chain solana` → copy full address from JSON.

## References

- Full parameters: `references/commands.md` (profiler section)
- Example response: `references/examples/profiler-balance.json`
- Schema: `references/schema.json`

> 📊 Data by [Nansen](https://nansen.ai)
