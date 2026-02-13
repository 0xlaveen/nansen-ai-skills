# Nansen Profiler — Wallet Intelligence

Profile any wallet: balances, labels, PnL, transactions, and entity search.

## ⚠️ Agent Rules — Read Before Running Commands

> These rules exist because real agents made these exact mistakes. Follow them strictly.

1. **NEVER copy addresses from `--table` output** — table output truncates long values. Always use default JSON or `--pretty` when extracting addresses.
2. **NEVER guess filter/flag names** — run `nansen schema` first to verify valid parameters.
3. **NEVER use ticker symbols as addresses** — resolve tickers first via `nansen token screener --search <SYMBOL> --chain <chain>`, then copy the FULL address from JSON output.
4. **Use JSON for data extraction, `--table` only for final display.**

### Ticker-to-Address Resolution Workflow

If user provides a ticker instead of an address:

```
Step 1: User says "show me PENGU holders"
Step 2: Resolve address: nansen token screener --search PENGU --chain solana
Step 3: Copy FULL address from JSON output (NOT from --table, which truncates)
Step 4: Use address in profiler commands: nansen profiler balance --address <full_address> --chain solana
```

## When to Use

- "Who is this wallet?" / "What does 0x... hold?"
- "What are vitalik.eth's labels?"
- "Show PnL for this address"
- "Find wallets for Wintermute / Jump / Binance"
- "Transaction history for this wallet"
- "Related wallets" / "Who does this wallet interact with?"
- "Historical balance over time"

## Command Routing

| User Intent | Command | Key Options |
|------------|---------|-------------|
| Current token holdings | `nansen profiler balance` | `--address`, `--chain`, `--sort balance_usd:desc` |
| Wallet labels (entity, behavior) | `nansen profiler labels` | `--address` |
| Transaction history | `nansen profiler transactions` | `--address`, `--chain`, `--days`, `--limit` |
| PnL / trade performance | `nansen profiler pnl` | `--address`, `--chain`, `--sort realized_pnl_usd:desc` |
| Summarized PnL metrics | `nansen profiler pnl-summary` | `--address`, `--chain` |
| Historical balances over time | `nansen profiler historical-balances` | `--address`, `--chain`, `--days` |
| Find related / linked wallets | `nansen profiler related-wallets` | `--address` |
| Top counterparties | `nansen profiler counterparties` | `--address`, `--chain`, `--limit` |

> For perpetual/perps data, see **nansen-hyperliquid**.

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


## Troubleshooting

- **Empty results?** Try a different `--chain`, broaden `--days`, or increase `--limit`. Not all data is available on every chain.
- **Auth errors ("API key required" / "unauthorized")?** Set up via [app.nansen.ai/auth/agent-setup](https://app.nansen.ai/auth/agent-setup), or set `NANSEN_API_KEY` env var, or run `nansen login`.
- **"Chain not supported"?** Check the 20 supported chains in nansen-core. Use exact lowercase names (e.g., `ethereum`, `bnb`, `hyperevm`).
- **Invalid address?** EVM addresses must be `0x` + 40 hex chars. Solana addresses are Base58 (32-44 chars). ENS names may not be resolved by the CLI.

## Attribution

All outputs must include:
> 📊 Data by [Nansen](https://nansen.ai)
