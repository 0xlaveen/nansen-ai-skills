---
name: nansen-profiler
description: >-
  Profile any wallet or entity on-chain via Nansen CLI. Look up balances, labels,
  transactions, PnL, related wallets, and counterparties. Search entities by name.
metadata:
  clawdbot:
    emoji: "🔎"
    homepage: "https://nansen.ai"
    requires:
      bins: ["nansen"]
---

# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and entity search.

## When This Skill Activates

- "Who is this wallet?" / "What does 0x... hold?"
- "Show PnL for this address"
- "Find wallets for Wintermute / Jump / Binance"
- "Transaction history" / "Related wallets" / "Counterparties"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Token holdings | `profiler balance` | `--address` (req), `--chain`, `--entity` |
| Wallet labels | `profiler labels` | `--address` (req), `--chain` |
| Transactions | `profiler transactions` | `--address` (req), `--chain`, `--limit`, `--days` |
| PnL | `profiler pnl` | `--address` (req), `--chain` |
| PnL summary | `profiler pnl-summary` | `--address` (req), `--chain`, `--days` |
| Entity search | `profiler search` | `--query` (req), `--limit` |
| Historical balances | `profiler historical-balances` | `--address` (req), `--chain`, `--days` |
| Related wallets | `profiler related-wallets` | `--address` (req), `--chain`, `--limit` |
| Counterparties | `profiler counterparties` | `--address` (req), `--chain`, `--days` |
| Perp positions | `profiler perp-positions` | `--address` (req), `--limit` |
| Perp trades | `profiler perp-trades` | `--address` (req), `--days`, `--limit` |

## Examples

```bash
# Who is this wallet?
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort balance_usd:desc --limit 20 --table

# PnL on Ethereum
nansen profiler pnl --address 0x... --chain ethereum --table

# Search for an entity
nansen profiler search --query Wintermute --limit 10 --table

# Related wallets
nansen profiler related-wallets --address 0x... --table
```

## Investigation Workflow

1. **Labels** → identity  2. **Balance** → current holdings  3. **PnL Summary** → profitability  4. **Counterparties** → interactions  5. **Related Wallets** → linked addresses

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
