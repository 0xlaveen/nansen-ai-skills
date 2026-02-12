# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and entity search.

## When to Use

- "Who is this wallet?" / "What does 0x... hold?"
- "What are vitalik.eth's labels?"
- "Show PnL for this address"
- "Find wallets for Wintermute / Jump / Binance"
- "Transaction history for this wallet"
- "Related wallets" / "Who does this wallet interact with?"
- "Historical balance over time"
- "Perp positions for this trader"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Current token holdings | `nansen profiler balance` | `--address`, `--chain`, `--sort value_usd:desc` |
| Wallet labels (entity, behavior) | `nansen profiler labels` | `--address` |
| Transaction history | `nansen profiler transactions` | `--address`, `--chain`, `--days`, `--limit` |
| PnL / trade performance | `nansen profiler pnl` | `--address`, `--chain`, `--sort realized_pnl_usd:desc` |
| Summarized PnL metrics | `nansen profiler pnl-summary` | `--address`, `--chain` |
| Search by entity name | `nansen profiler search` | `--query "name"` |
| Historical balances over time | `nansen profiler historical-balances` | `--address`, `--chain`, `--days` |
| Find related / linked wallets | `nansen profiler related-wallets` | `--address` |
| Top counterparties | `nansen profiler counterparties` | `--address`, `--chain`, `--limit` |
| Current perp positions | `nansen profiler perp-positions` | `--address` |
| Perp trading history | `nansen profiler perp-trades` | `--address`, `--limit` |

> **Tip:** Run `nansen schema` to discover all options and return fields dynamically.

## Address Formats

- **EVM chains**: `0x` + 40 hex characters
- **Solana**: Base58 string, 32–44 characters
- **ENS names**: The CLI may not resolve ENS — use raw addresses when possible

## Examples

### Who is this wallet?
```bash
nansen profiler labels --address 0x... --table
nansen profiler balance --address 0x... --sort balance_usd:desc --limit 20 --table
```

### Find wallets for Wintermute
```bash
nansen profiler search --query "Wintermute" --table
```

### PnL for an address on Ethereum
```bash
nansen profiler pnl --address 0x... --chain ethereum --table
```

### PnL summary
```bash
nansen profiler pnl-summary --address 0x... --chain ethereum --table
```

### Transaction history for the last 7 days
```bash
nansen profiler transactions --address 0x... --chain ethereum --days 7 --limit 50 --table
```

### Historical balance over 30 days
```bash
nansen profiler historical-balances --address 0x... --chain ethereum --days 30 --table
```

### Find related wallets
```bash
nansen profiler related-wallets --address 0x... --table
```

### Top counterparties
```bash
nansen profiler counterparties --address 0x... --chain ethereum --table
```

### Perp positions
```bash
nansen profiler perp-positions --address 0x... --table
```

## Wallet Investigation Workflow

1. **Labels** — Identify the entity/behavior
2. **Balance** — What do they hold now?
3. **PnL Summary** — Are they profitable?
4. **Counterparties** — Who do they interact with?
5. **Related Wallets** — Are there linked addresses?

## Output Formatting

- Use `--table` for user display
- For balance queries, sort by `balance_usd:desc` to show largest positions first
- For PnL, highlight total realized/unrealized PnL
- When showing labels, format as a clean list with entity name and label type

## Cross-References

- Found an entity? → Use smart money commands to see their classification
- See token holdings? → Use token commands to analyze those tokens
- See perp positions? → Use Hyperliquid commands for deeper analysis

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
